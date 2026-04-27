   import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showSnackBar(BuildContext context, {required String text, required Color color}) {
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: CustomTextWidget(
      text:  text,
      textStyle: TextStyle(color: AppColors.white, fontWeight: FontDetails.semiBoldFontWeight),
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: color,
    elevation: 10, 
    margin: const EdgeInsets.all(20), 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.r),
    ),
    duration: const Duration(seconds: 2),
  ),
);
  }