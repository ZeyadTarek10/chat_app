import 'package:chat_app/features/message_groups/presentation/screens/widgets/group_message_buble.dart';
import 'package:flutter/material.dart';

class ListViewGroupMessageBuble extends StatelessWidget {
  const ListViewGroupMessageBuble({
    super.key,
    required this.controller0,
    required this.dummyMessages,
  });

  final ScrollController controller0;
  final List<Map<String, dynamic>> dummyMessages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      controller: controller0,
      padding: const EdgeInsets.only(top: 16),
      itemCount: dummyMessages.length,
      itemBuilder: (context, index) {
        final msg = dummyMessages[index];

        if (msg['isMe'] == true) {
          return GroupsMessageBubleForYou(
            message: msg['text'],
            time: msg['time'],
          );
        } else {
          return GroupMessageBuble(
            message: msg['text'],
            time: msg['time'],
            senderName: msg['senderName'],
            avatarUrl: msg['avatar'],
          );
        }
      },
    );
  }
}