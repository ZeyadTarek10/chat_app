import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostFloatingButton extends StatelessWidget {
  const PostFloatingButton({super.key, required this.icon, this.iconColor});

  final IconData icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: context.color.chatBackgroundColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: context.color.textColor!.withOpacity(0.03),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Icon(icon, color: iconColor, size: 20.sp),
    );
  }
}
