import 'package:chat_app/features/groups/domain/entities/groups_entity.dart';
import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:chat_app/features/message_groups/presentation/screens/widgets/group_message_buble.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListViewGroupMessageBuble extends StatelessWidget {
  const ListViewGroupMessageBuble({
    super.key,
    required this.controller0,
    required this.messages,
    required this.group,
  });

  final ScrollController controller0;
  final List<MessageEntity> messages;
  final GroupsEntity group;

  @override
  Widget build(BuildContext context) {
    final myUid = FirebaseAuth.instance.currentUser?.uid;
    return ListView.builder(
      reverse: true,
      controller: controller0,
      padding: const EdgeInsets.only(top: 16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        final bool isMe = msg.fromId == myUid;
        
        final String time = msg.createdAt != null 
            ? DateFormat('hh:mm a').format(msg.createdAt!) 
            : "";

       if (isMe) {
        bool isRead = msg.read != null && msg.read!.isNotEmpty;
          return GroupsMessageBubleForYou(
            message: msg.message ?? "",
            time: time,
            isRead: isRead,
          );
        } else {
          String senderName = "unknown".tr();
          String avatarUrl = ""; 

          if (msg.fromId != null) {
            int memberIndex = group.members.indexOf(msg.fromId!);
            if (memberIndex != -1) {
              if (memberIndex < group.memberNames.length) {
                senderName = group.memberNames[memberIndex];
              }
              if (memberIndex < group.image.length) {
                avatarUrl = group.image[memberIndex];
              }
            }
          }
          return GroupMessageBuble(
            message: msg.message ?? "",
            time: time,
            senderName: senderName, 
            avatarUrl: avatarUrl, text: senderName.isNotEmpty ? senderName[0].toUpperCase() : "", 
          );
        }
      },
    );
  }
}