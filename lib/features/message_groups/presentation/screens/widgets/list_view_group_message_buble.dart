import 'dart:io';

import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/date_helper.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/groups/domain/entities/groups_entity.dart';
import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:chat_app/features/message_groups/presentation/manager/cubit/messege_group_cubit.dart';
import 'package:chat_app/features/message_groups/presentation/screens/widgets/group_message_buble.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swipe_to/swipe_to.dart';

class ListViewGroupMessageBuble extends StatelessWidget {
  const ListViewGroupMessageBuble({
    super.key,
    required this.controller0,
    required this.messages,
    required this.group,
    required this.focusNode,
    this.pendingImagePath,
  });

  final ScrollController controller0;
  final List<MessageEntity> messages;
  final GroupsEntity group;
  final FocusNode focusNode;
  final String? pendingImagePath;

  @override
  Widget build(BuildContext context) {
    final myUid = FirebaseAuth.instance.currentUser?.uid;
    final messegeGroupCubit = context.read<MessegeGroupCubit>();
    final hasPending =
        pendingImagePath != null && pendingImagePath!.isNotEmpty;
    final extraCount = hasPending ? 1 : 0;
    return ListView.builder(
      reverse: true,
      controller: controller0,
      padding: const EdgeInsets.only(top: 16),
      itemCount: messages.length + extraCount,
      itemBuilder: (context, index) {
        if (hasPending && index == 0) {
          return _PendingGroupImageBubble(path: pendingImagePath!);
        }
        final actualIndex = index - extraCount;
        final msg = messages[actualIndex];
        final bool isMe = msg.fromId == myUid;

        final String time = msg.createdAt != null
            ? DateFormat('hh:mm a').format(msg.createdAt!)
            : "";

        bool showHeader = false;
        if (actualIndex == messages.length - 1) {
          showHeader = true;
        } else {
          final previousMessageTime = messages[actualIndex + 1].createdAt;
          if (msg.createdAt != null && previousMessageTime != null) {
            if (!DateHelper.isSameDay(
                msg.createdAt!, previousMessageTime)) {
              showHeader = true;
            }
          }
        }

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

        Widget messageWidget = SwipeTo(
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

        if (showHeader && msg.createdAt != null) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: ColorsDark.googlebtnColor,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: CustomTextWidget(
                    text: DateHelper.getChatDayHeader(msg.createdAt!),
                    textStyle: TextStyle(
                      fontSize: 12.sp,
                      color: ColorsLight.mainTextColor,
                      fontWeight: FontDetails.boldFontWeight,
                    ),
                  ),
                ),
              ),
              messageWidget,
            ],
          );
        }

        return messageWidget;
      },
    );
  }

  void _handleSwipe(MessageEntity msg, MessegeGroupCubit cubit) {
    cubit.selectReplyMessage(msg);
    focusNode.requestFocus();
  }
}

class _PendingGroupImageBubble extends StatelessWidget {
  final String path;
  const _PendingGroupImageBubble({required this.path});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: EdgeInsets.all(6.r),
        margin:
            const EdgeInsetsDirectional.only(end: 16, start: 60, bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xff1565C0),
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(16.r),
            topEnd: Radius.circular(16.r),
            bottomStart: Radius.circular(16.r),
            bottomEnd: Radius.circular(4.r),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.file(
                File(path),
                width: 200.w,
                height: 200.w,
                fit: BoxFit.cover,
              ),
              Container(
                width: 200.w,
                height: 200.w,
                color: Colors.black.withOpacity(0.45),
              ),
              SizedBox(
                width: 40.w,
                height: 40.w,
                child: const CircularProgressIndicator(
                  color: ColorsDark.white,
                  strokeWidth: 2.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
