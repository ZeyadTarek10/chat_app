import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionItemAddPostBottomSheet extends StatelessWidget {
  const ActionItemAddPostBottomSheet(
      {super.key, this.icon, required this.text, this.onTap});

  final IconData? icon;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: context.color.navBarbg!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: context.color.textColor!.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Icon(icon, color: ColorsLight.mainTextColor, size: 20.sp),
            SizedBox(width: 5.w),
            CustomTextWidget(
              text: text,
              textStyle: TextStyle(
                  color: ColorsLight.mainTextColor,
                  fontSize: FontDetails.fontSizeS),
            ),
          ],
        ),
      ),
    );
  }
}
