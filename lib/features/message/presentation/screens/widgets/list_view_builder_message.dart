import 'package:chat_app/features/message/presentation/screens/widgets/message_buble.dart';
import 'package:flutter/material.dart';

class ListViewBuilderMessage extends StatelessWidget {
  const ListViewBuilderMessage({
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
          return MessageBubleForYou(
            message: msg['text'],
            time: msg['time'],
          );
        } else {
          return MessageBuble(
            message: msg['text'],
            time: msg['time'],
          );
        }
      },
    );
  }
}