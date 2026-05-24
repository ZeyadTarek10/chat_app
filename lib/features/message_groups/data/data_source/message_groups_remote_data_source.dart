import 'package:chat_app/features/message/data/models/message_model.dart';
import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class MessageGroupsRemoteDataSource {
  Future<void> sendGroupMessage({required String message, required String groupId, String? type, MessageEntity? replyMessage,});
  Stream<List<MessageModel>> getGroupMessages(String groupId);
  Future<void> markMessageAsRead(String groupId, String messageId);
}

class MessageGroupsRemoteDataSourceImpl implements MessageGroupsRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> sendGroupMessage({required String message, required String groupId, String? type, MessageEntity? replyMessage}) async {
    
    String msgId = FirebaseFirestore.instance.collection("groups").doc(groupId).collection("messages").doc().id; 
    String myUid = FirebaseAuth.instance.currentUser!.uid;
    
    MessageModel messagesModel = MessageModel(
      id: msgId,
      message: message,
      createdAt: DateTime.now(),
      toId: "",
      fromId: myUid,
      type: type ?? "text",
      read: "", 
      replyMessage: replyMessage,
    );

    await FirebaseFirestore.instance
        .collection("groups")
        .doc(groupId)
        .collection("messages")
        .doc(msgId)
        .set(messagesModel.toJson());

    DocumentSnapshot groupDoc = await FirebaseFirestore.instance.collection("groups").doc(groupId).get();
    
    if (groupDoc.exists) {
      var data = groupDoc.data() as Map<String, dynamic>;
      List<dynamic> members = data['members'] ?? [];

      Map<String, dynamic> updates = {
        "last_message": type == "text" ? message : "📷 Image", 
        "last_message_time": DateTime.now().millisecondsSinceEpoch.toString(),
      };

      for (String memberId in members) { 
        if (memberId != myUid) {
          updates['unread_counts.$memberId'] = FieldValue.increment(1);
        }
      }

      await FirebaseFirestore.instance.collection('groups').doc(groupId).update(updates);
    }
  }

  @override
  Stream<List<MessageModel>> getGroupMessages(String groupId) {
    return firestore
        .collection("groups")
        .doc(groupId)
        .collection("messages")
        .orderBy("created_at", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MessageModel.fromJson(doc.data()))
            .toList());
  }

  @override
  Future<void> markMessageAsRead(String groupId, String messageId) async {
    await FirebaseFirestore.instance
        .collection("groups")
        .doc(groupId)
        .collection("messages")
        .doc(messageId)
        .update({"read": "read"}); 
  }
}