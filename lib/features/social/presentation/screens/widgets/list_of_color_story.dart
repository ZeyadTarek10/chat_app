import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/social/presentation/manager/story_cubit/story_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListOfColorStory extends StatelessWidget {
  const ListOfColorStory({
    super.key,
    required List<int> backgroundColors,
    required this.cubit,
    required this.selectedClr,
  }) : _backgroundColors = backgroundColors;

  final List<int> _backgroundColors;
  final StoryCubit cubit;
  final int selectedClr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _backgroundColors.map((colorValue) {
        return GestureDetector(
          onTap: () => cubit.updateStoryColor(colorValue),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5.h),
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              color: Color(colorValue),
              shape: BoxShape.circle,
              border: Border.all(
                  color: selectedClr == colorValue
                      ? ColorsDark.white
                      : Colors.transparent,
                  width: 2.w),
            ),
          ),
        );
      }).toList(),
    );
  }
}
