import 'package:flutter/material.dart';
import 'package:flutter_helper/core/utils/app_colors.dart';

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
      height: 8,
      width: currentPage == index ? 8 : 8,
      decoration: BoxDecoration(
        color: currentPage == index
            ? AppColors.backgroundColorbuttonblue2
            : AppColors.backgroundColorbuttonblue2.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
