import 'package:chat_app/features/message/data/models/message_model.dart';
import 'package:chat_app/features/sign_up/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class MessageRemoteDataSource {
  Future<void> sendMessage(
      {required MessageModel messageModel, required String roomId});
  Future<void> readMessage({required String roomId, required String msgId});
  Stream<List<MessageModel>> getMessages({required String roomId});
  Future<UserModel> getUserById({required String uid});
  Future<void> deleteRoom({required String roomId});
  Future<void> clearChatMessages({required String roomId});
}

class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  @override
  Future<void> sendMessage(
      {required MessageModel messageModel, required String roomId}) async {
    try {
      await firestore
          .collection("chats")
          .doc(roomId)
          .collection("messages")
          .doc(messageModel.id)
          .set(messageModel.toJson());

      await firestore.collection("chats").doc(roomId).update({
        "last_message":
            messageModel.type == "text" ? messageModel.message : "Image",
        "last_message_time":
            messageModel.createdAt ?? FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> readMessage(
      {required String roomId, required String msgId}) async {
    await firestore
        .collection("chats")
        .doc(roomId)
        .collection("messages")
        .doc(msgId)
        .update({"read": DateTime.now().millisecondsSinceEpoch.toString()});
    await firestore.collection("chats").doc(roomId).set({
      "last_read_activity": DateTime.now().millisecondsSinceEpoch.toString(),
    }, SetOptions(merge: true));
  }

  @override
  @override
  Stream<List<MessageModel>> getMessages({required String roomId}) {
    return firestore
        .collection("chats")
        .doc(roomId)
        .collection("messages")
        .orderBy("created_at", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MessageModel.fromJson(doc.data()))
          .toList();
    });
  }

  @override
  Future<UserModel> getUserById({required String uid}) async {
    final doc = await firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    } else {
      throw Exception("user_not_found".tr());
    }
  }

  @override
  Future<void> deleteRoom({required String roomId}) async {
    await firestore.collection("chats").doc(roomId).delete();
  }

   @override
  Future<void> clearChatMessages({required String roomId}) async {
  try {
    final messagesRef = firestore.collection("chats").doc(roomId).collection("messages");
    final snapshots = await messagesRef.get();

    WriteBatch batch = firestore.batch();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();

    await firestore.collection("chats").doc(roomId).set({
      "last_message": "Chat cleared", 
    }, SetOptions(merge: true));
    
  } catch (e) {
    throw Exception(e.toString());
  }
}
}
