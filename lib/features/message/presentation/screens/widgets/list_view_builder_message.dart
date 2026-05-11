import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:chat_app/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:chat_app/features/message/presentation/screens/message_screen.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/message_buble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListViewBuilderMessages extends StatelessWidget {
  const ListViewBuilderMessages({
    super.key,
    required this.messageCubit,
    required this.messages,
    required this.widget,
  });

  final MessageCubit messageCubit;
  final List<MessageEntity> messages;
  final MessageScreen widget;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: messageCubit.controller0,
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        final time = context.read<MessageCubit>().formatMessageTime(msg.createdAt);

        final myUid = FirebaseAuth.instance.currentUser!.uid;
        if (msg.toId == myUid && msg.read == "") {
          context.read<MessageCubit>().readMessage(widget.roomId, msg.id!);
        }
        bool isMe = msg.fromId == myUid;
        bool isRead = msg.read != null && msg.read!.isNotEmpty;
        return isMe
            ? MessageBubleForYou(
                message: msg.message ?? "",
                time: time,
                isRead: isRead,
              )
            : MessageBuble(
                message: msg.message ?? "",
                time: time,
              );
      },
    );
  }
}
