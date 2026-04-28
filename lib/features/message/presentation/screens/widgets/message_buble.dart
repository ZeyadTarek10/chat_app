import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageBuble extends StatelessWidget {
  final String message;
  final String time;

  const MessageBuble({super.key, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        margin: const EdgeInsets.only(left: 16, right: 60, bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(4.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
              text: message,
              textStyle: TextStyle(color: AppColors.black, fontSize: FontDetails.fontSizeS),
            ),
            SizedBox(height: 6.h),
            CustomTextWidget(
              text: time,
              textStyle: TextStyle(color: Colors.grey.shade400, fontSize: FontDetails.fontSizeXS),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubleForYou extends StatelessWidget {
  final String message;
  final String time;

  const MessageBubleForYou({super.key, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        margin: const EdgeInsets.only(right: 16, left: 60, bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xff1565C0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(16.r),
            bottomRight: Radius.circular(4.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomTextWidget(
              text: message,
              textStyle: TextStyle(color: AppColors.white, fontSize: FontDetails.fontSizeS),
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextWidget(
                 text: time,
                  textStyle: TextStyle(color: Colors.white70, fontSize: FontDetails.fontSizeXS),
                ),
                SizedBox(width: 4.w),
                Icon(Icons.done_all, color: AppColors.white, size: FontDetails.fontSizeS),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

