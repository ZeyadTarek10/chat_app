import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleButtonAppBarProductsScreen extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  
  const CircleButtonAppBarProductsScreen({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50.r),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.w),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: ColorsLight.mainTextColor.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: context.color.textColor),
      ),
    );
  }
}