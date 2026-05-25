import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:chat_app/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:chat_app/features/message/presentation/screens/message_screen.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/message_buble.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        bool showHeader = false;
        if (index == messages.length - 1) {
          showHeader = true;
        } else {
          final previousMessageTime = messages[index + 1].createdAt;
          if (msg.createdAt != null && previousMessageTime != null) {
            if (!messageCubit.isSameDay(msg.createdAt!, previousMessageTime)) {
              showHeader = true;
            }
          }
        }

        final myUid = FirebaseAuth.instance.currentUser!.uid;
        if (msg.toId == myUid && msg.read == "") {
          context.read<MessageCubit>().readMessage(widget.roomId, msg.id!);
        }
        bool isMe = msg.fromId == myUid;
        bool isRead = msg.read != null && msg.read!.isNotEmpty;
        Widget messageWidget = SwipeTo(
          key: ValueKey(msg.id),
          onLeftSwipe: isMe ? (direction) => _handleSwipe(msg) : null,
          onRightSwipe: !isMe ? (direction) => _handleSwipe(msg) : null,
          child: isMe
              ? MessageBubleForMe(type: msg.type ?? "text",message: msg.message ?? "", time: time, isRead: isRead, replyMessage: msg.replyMessage)
              : MessageBuble(type: msg.type ?? "text",message: msg.message ?? "", time: time, replyMessage: msg.replyMessage),
        );
      if (showHeader && msg.createdAt != null) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: ColorsDark.googlebtnColor, 
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: CustomTextWidget(
                    text: messageCubit.getChatDayHeader(msg.createdAt!),
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

  void _handleSwipe(MessageEntity msg) {
    messageCubit.selectReplyMessage(msg);
    focusNode.requestFocus(); 
  }
}
