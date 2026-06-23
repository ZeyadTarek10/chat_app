import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CircleButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50.r),
      child: Container(
        decoration: BoxDecoration(
          color: context.color.chatBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: context.color.textColor, size: 20.sp),
      ),
    );
  }
}