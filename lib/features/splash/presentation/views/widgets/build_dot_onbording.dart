import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildDotOnbording extends StatelessWidget {
  const BuildDotOnbording(
      {super.key, required this.index, required this.currentPage});

  final int index;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 6),
      height: 8.h,
      width: currentPage == index ? 8.w : 8.w,
      decoration: BoxDecoration(
        color: currentPage == index
            ? AppColors.backgroundColorbuttonblue2
            : AppColors.backgroundColorbuttonblue2.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}
