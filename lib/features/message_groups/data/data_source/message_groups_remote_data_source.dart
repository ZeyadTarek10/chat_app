import 'package:chat_app/features/message/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class MessageGroupsRemoteDataSource {
  Future<void> sendGroupMessage({required String message, required String groupId, String? type});
  Stream<List<MessageModel>> getGroupMessages(String groupId);
  Future<void> markMessageAsRead(String groupId, String messageId);
}

class MessageGroupsRemoteDataSourceImpl implements MessageGroupsRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> sendGroupMessage({required String message, required String groupId, String? type}) async {
    
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
    );

    await FirebaseFirestore.instance
        .collection("groups")
        .doc(groupId)
        .collection("messages")
        .doc(msgId)
        .set(messagesModel.toJson());

    await FirebaseFirestore.instance.collection("groups").doc(groupId).update({
      "last_message": type == "text" ? message : "Image ",
      "last_message_time": DateTime.now().millisecondsSinceEpoch.toString(),
    });
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