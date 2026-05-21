import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/reply_message_widget.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupMessageBuble extends StatelessWidget {
  final String message;
  final String time;
  final String senderName;
  final String replySenderName;
  final String avatarUrl;
  final String text;
  final MessageEntity? replyMessage;
  final String type;

  const GroupMessageBuble({
    super.key,
    required this.message,
    required this.time,
    required this.senderName,
    required this.avatarUrl,
    required this.text,
    this.replyMessage,
    required this.replySenderName,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16, end: 60, bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: FontDetails.fontSizeS,
            backgroundImage:
                avatarUrl.isNotEmpty ? NetworkImage(avatarUrl) : null,
            backgroundColor: ColorsDark.backgroundColorCircleButtonblue3,
            child: avatarUrl.isEmpty
                ? CustomTextWidget(
                    text: text.isNotEmpty ? text[0].toUpperCase() : "",
                    textStyle: const TextStyle(color: ColorsDark.white),
                  )
                : null,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: 4, bottom: 4),
                  child: CustomTextWidget(
                    text: senderName,
                    textStyle: TextStyle(
                      color: ColorsLight.mainTextColor,
                      fontSize: FontDetails.fontSizeXS,
                      fontWeight: FontDetails.mediumFontWeight,
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
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
                          child: ReplyMessageWidget(
                            message: replyMessage!.type == "image"
                                ? replyMessage!
                                    .copyWith(message: "🖼 ${'photo'.tr()}")
                                : replyMessage!,
                            friendName: replySenderName,
                          ),
                        ),
                        SizedBox(height: 8.h),
                      ],
                      type == "image"
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: CachedNetworkImage(
                                imageUrl: message,
                                placeholder: (context, url) => SizedBox(
                                  width: 150.w,
                                  height: 150.h,
                                  child: const Center(
                                      child: CircularProgressIndicator(
                                          color: ColorsDark.blueLight1)),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                        Icons.image_not_supported_outlined,
                                        size: 50),
                                width: 200.w,
                                fit: BoxFit.cover,
                              ),
                            )
                          : CustomTextWidget(
                              text: message,
                              textStyle: TextStyle(
                                  color: ColorsLight.black,
                                  fontSize: FontDetails.fontSizeS,
                                  height: 1.3.h),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GroupsMessageBubleForYou extends StatelessWidget {
  final String message;
  final String time;
  final bool isRead;
  final MessageEntity? replyMessage;
  final String replySenderName;
  final String type;

  const GroupsMessageBubleForYou({
    super.key,
    required this.message,
    required this.time,
    this.isRead = false,
    this.replyMessage,
    required this.replySenderName,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        margin:
            const EdgeInsetsDirectional.only(end: 16, start: 60, bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1565C0),
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
                child: ReplyMessageWidget(
                  message: replyMessage!.type == "image"
                      ? replyMessage!.copyWith(message: "🖼 ${'photo'.tr()}")
                      : replyMessage!,
                  friendName: replySenderName,
                ),
              ),
              SizedBox(height: 8.h),
            ],
            type == "image"
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: CachedNetworkImage(
                      imageUrl: message,
                      placeholder: (context, url) => SizedBox(
                        width: 150.w,
                        height: 150.h,
                        child: const Center(
                            child: CircularProgressIndicator(
                                color: ColorsDark.white)),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                          Icons.image_not_supported_outlined,
                          size: 50,
                          color: Colors.white),
                      width: 200.w,
                      fit: BoxFit.cover,
                    ),
                  )
                : CustomTextWidget(
                    text: message,
                    textStyle: TextStyle(
                        color: ColorsDark.white,
                        fontSize: FontDetails.fontSizeS,
                        height: 1.3.h),
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
