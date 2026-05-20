import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:chat_app/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:chat_app/features/message/presentation/screens/message_screen.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/message_buble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipe_to/swipe_to.dart';

class ListViewBuilderMessages extends StatelessWidget {
  const ListViewBuilderMessages({
    super.key,
    required this.messageCubit,
    required this.messages,
    required this.widget,
    required this.focusNode,
  });

  final MessageCubit messageCubit;
  final List<MessageEntity> messages;
  final MessageScreen widget;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: messageCubit.controller0,
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        final time =
            context.read<MessageCubit>().formatMessageTime(msg.createdAt);

        final myUid = FirebaseAuth.instance.currentUser!.uid;
        if (msg.toId == myUid && msg.read == "") {
          context.read<MessageCubit>().readMessage(widget.roomId, msg.id!);
        }
        bool isMe = msg.fromId == myUid;
        bool isRead = msg.read != null && msg.read!.isNotEmpty;
        return SwipeTo(
          key: ValueKey(msg.id),
          onLeftSwipe: isMe ? (direction) => _handleSwipe(msg) : null,
          onRightSwipe: !isMe ? (direction) => _handleSwipe(msg) : null,
          child: isMe
              ? MessageBubleForMe(message: msg.message ?? "", time: time, isRead: isRead, replyMessage: msg.replyMessage)
              : MessageBuble(message: msg.message ?? "", time: time, replyMessage: msg.replyMessage),
        );
      },
    );
  }

  void _handleSwipe(MessageEntity msg) {
    messageCubit.selectReplyMessage(msg);
    focusNode.requestFocus(); 
  }
}
