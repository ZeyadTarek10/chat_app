import 'package:chat_app/features/chats/data/models/chats_model.dart';
import 'package:chat_app/features/sign_up/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ChatsRemoteDataSource {
  Future<ChatsModel> createChat({required String phone});
  Stream<List<ChatsModel>> getChatsList();
  Future<List<UserModel>> searchUserByPhone({required String phone});
}

class ChatsRemoteDataSourceImpl implements ChatsRemoteDataSource {
  ChatsRemoteDataSourceImpl();

  @override
  Future<ChatsModel> createChat({required String phone}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String myUid = _requireUid();

    QuerySnapshot userEmail = await firestore
        .collection('users')
        .where('phone', isEqualTo: phone)
        .get();

    if (userEmail.docs.isEmpty) {
      throw Exception("no_user_found_with_this_phone".tr());
    }

    String userId = userEmail.docs.first.id;
    List<String> members = [myUid, userId]..sort((a, b) => a.compareTo(b));
    String roomId = generateRoomId(myUid, userId);

    DocumentSnapshot roomDoc =
        await firestore.collection('chats').doc(roomId).get();

    if (!roomDoc.exists) {
      ChatsModel chatsModel = ChatsModel(
          id: roomId,
          members: members,
          lastMessage: '',
          lastMessageTime: DateTime.now(),
          createdAt: DateTime.now());

      await firestore.collection('chats').doc(roomId).set(chatsModel.toJson());

      return chatsModel;
    } else {
      return ChatsModel.fromJson(roomDoc.data() as Map<String, dynamic>);
    }
  }

  String _requireUid() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      throw Exception("user_is_not_logged_in".tr());
    }
    return uid;
  }

  @override
  Stream<List<ChatsModel>> getChatsList() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String myUid = _requireUid();

    return firestore
        .collection('chats')
        .where('members', arrayContains: myUid)
        .snapshots()
        .asyncMap((snapshot) async {
      List<ChatsModel> chatsList = [];

      for (var doc in snapshot.docs) {
        Map<String, dynamic> roomData = doc.data();
        List members = roomData['members'] ?? [];
        String friendId =
            members.firstWhere((id) => id != myUid, orElse: () => "");

        String fName = "Unknown";
        String fImage = "";

        if (friendId.isNotEmpty) {
          var userDoc = await firestore.collection('users').doc(friendId).get();
          if (userDoc.exists) {
            fName = userDoc['name'] ?? "Unknown";
            fImage = userDoc['profile_pic_url'] ?? '';
          }
        }

        var unreadMessages = await firestore
            .collection('chats')
            .doc(doc.id)
            .collection('messages')
            .where('to_id', isEqualTo: myUid)
            .where('read', isEqualTo: "")
            .count()
            .get();

        int unreadCount = unreadMessages.count ?? 0;

        roomData['friend_name'] = fName;
        roomData['friend_image'] = fImage;
        roomData['unread_count'] = unreadCount;
        roomData['id'] = doc.id;

        chatsList.add(ChatsModel.fromJson(roomData));
      }

      chatsList.sort((a, b) {
  DateTime timeA = a.lastMessageTime ?? DateTime.fromMillisecondsSinceEpoch(0);
  DateTime timeB = b.lastMessageTime ?? DateTime.fromMillisecondsSinceEpoch(0);
  
  return timeB.compareTo(timeA); 
});
      return chatsList;
    });
  }

  @override
  Future<List<UserModel>> searchUserByPhone({required String phone}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .where('phone', isEqualTo: phone)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return [];
    }

    return querySnapshot.docs.map((doc) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}

String generateRoomId(String uid1, String uid2) {
  List<String> members = [uid1, uid2]..sort();
  return members.join();
}
