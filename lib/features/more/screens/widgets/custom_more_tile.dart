import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomMoreTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing; 
  final VoidCallback? onTap;
  final Color? textColor;
  final Color? iconColor;

  const CustomMoreTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
      leading: Icon(icon, color: iconColor ?? context.color.textColor, size: 20.sp),
      title: CustomTextWidget(
        text: title,
        textStyle: TextStyle(
          fontSize: FontDetails.fontSizeM,
          fontWeight: FontDetails.boldFontWeight,
          color: textColor ?? context.color.textColor,
        ),
      ),
      trailing: trailing ?? Icon(CupertinoIcons.chevron_right, color: context.color.textColor, size: 20.sp),
      onTap: onTap,
    );
  }
}