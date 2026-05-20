import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:chat_app/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/reply_message_widget.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageBuble extends StatelessWidget {
  final String message;
  final String time;
  final MessageEntity? replyMessage;

  const MessageBuble({super.key, required this.message, required this.time, required this.replyMessage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        margin:
            const EdgeInsetsDirectional.only(start: 16, end: 60, bottom: 12),
        decoration: BoxDecoration(
          color: ColorsDark.white,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(16.r),
            topEnd: Radius.circular(16.r),
            bottomEnd: Radius.circular(16.r),
            bottomStart: Radius.circular(4.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (replyMessage != null) ...[
               Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                margin: EdgeInsets.only(bottom: 8.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border(
                    left: BorderSide(
                      color: ColorsDark.blueLight1,
                      width: 4.w,
                    ),
                  ),
                ),
                child: ReplyMessageWidget(message: replyMessage!, friendName: context.read<MessageCubit>().friendModel?.name ?? "Friend",),
              ),
              SizedBox(height: 8.h),
            ],
            CustomTextWidget(
              text: message,
              textStyle: TextStyle(
                  color: ColorsLight.black, fontSize: FontDetails.fontSizeS),
            ),
            SizedBox(height: 6.h),
            CustomTextWidget(
              text: time,
              textStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: FontDetails.fontSizeXS),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubleForMe extends StatelessWidget {
  final String message;
  final String time;
  final bool isRead;
   final MessageEntity? replyMessage;

  const MessageBubleForMe(
      {super.key,
      required this.message,
      required this.time,
      required this.isRead, required this.replyMessage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
             if (replyMessage != null) ...[
               Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                margin: EdgeInsets.only(bottom: 8.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border(
                    left: BorderSide(
                      color: ColorsDark.blueLight1,
                      width: 4.w,
                    ),
                  ),
                ),
                child: ReplyMessageWidget(message: replyMessage!, friendName: context.read<MessageCubit>().friendModel?.name ?? "Friend",),
              ),
              SizedBox(height: 8.h),
            ],
            CustomTextWidget(
              text: message,
              textStyle: TextStyle(
                  color: ColorsDark.white, fontSize: FontDetails.fontSizeS),
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextWidget(
                  text: time,
                  textStyle: TextStyle(
                      color: Colors.white70, fontSize: FontDetails.fontSizeXS),
                ),
                SizedBox(width: 4.w),
                Icon(Icons.done_all,
                    color: isRead ? ColorsDark.mainColor : ColorsDark.white,
                    size: FontDetails.fontSizeS),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
