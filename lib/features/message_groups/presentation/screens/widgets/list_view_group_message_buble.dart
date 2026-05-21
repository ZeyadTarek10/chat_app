import 'package:chat_app/features/groups/domain/entities/groups_entity.dart';
import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:chat_app/features/message_groups/presentation/manager/cubit/messege_group_cubit.dart';
import 'package:chat_app/features/message_groups/presentation/screens/widgets/group_message_buble.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipe_to/swipe_to.dart';

class ListViewGroupMessageBuble extends StatelessWidget {
  const ListViewGroupMessageBuble({
    super.key,
    required this.controller0,
    required this.messages,
    required this.group,
    required this.focusNode,
  });

  final ScrollController controller0;
  final List<MessageEntity> messages;
  final GroupsEntity group;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final myUid = FirebaseAuth.instance.currentUser?.uid;
    final messegeGroupCubit = context.read<MessegeGroupCubit>();
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

        String senderName = "unknown".tr();
        String avatarUrl = "";
        if (!isMe && msg.fromId != null) {
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

        String replySenderName = "";
        if (msg.replyMessage != null && msg.replyMessage!.fromId != null) {
          if (msg.replyMessage!.fromId == myUid) {
            replySenderName = "you".tr();
          } else {
            int replyIndex = group.members.indexOf(msg.replyMessage!.fromId!);
            if (replyIndex != -1 && replyIndex < group.memberNames.length) {
              replySenderName = group.memberNames[replyIndex];
            } else {
              replySenderName = "unknown".tr();
            }
          }
        }

        return SwipeTo(
          key: ValueKey(msg.id),
          onLeftSwipe:
              isMe ? (direction) => _handleSwipe(msg, messegeGroupCubit) : null,
          onRightSwipe: !isMe
              ? (direction) => _handleSwipe(msg, messegeGroupCubit)
              : null,
          child: isMe
              ? GroupsMessageBubleForYou(
                  message: msg.message ?? "",
                  time: time,
                  isRead: msg.read != null && msg.read!.isNotEmpty,
                  replyMessage: msg.replyMessage,
                  replySenderName: replySenderName,
                  type: msg.type ?? "text",
                )
              : GroupMessageBuble(
                  message: msg.message ?? "",
                  time: time,
                  senderName: senderName,
                  replySenderName: replySenderName,
                  avatarUrl: avatarUrl,
                  text:
                      senderName.isNotEmpty ? senderName[0].toUpperCase() : "",
                  replyMessage: msg.replyMessage,
                  type: msg.type ?? "text",
                ),
        );
      },
    );
  }

  void _handleSwipe(MessageEntity msg, MessegeGroupCubit cubit) {
    cubit.selectReplyMessage(msg);
    focusNode.requestFocus();
  }
}
