import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildMenuDrawarItem extends StatelessWidget {
  const BuildMenuDrawarItem({super.key, required this.icon, required this.title, required this.iconColor, required this.onTap});

  final IconData icon;
  final String title;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: Colors.transparent,
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, color: iconColor, size: 22.sp),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: CustomTextWidget(
                  text: title,
                  textStyle: TextStyle(
                    fontSize: FontDetails.fontSizeM,
                    fontWeight: FontDetails.boldFontWeight,
                    color: ColorsLight.mainTextColor,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 16.sp, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}
