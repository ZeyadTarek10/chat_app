import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/social/presentation/manager/story_cubit/story_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LinearProgressIndicatorStory extends StatelessWidget {
  const LinearProgressIndicatorStory({
    super.key,
    required this.group,
    required this.animController,
    required this.currentStoryIndex,
  });

  final UserStoryGroup group;
  final AnimationController animController;
  final int currentStoryIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        group.stories.length,
        (index) => Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: AnimatedBuilder(
              animation: animController,
              builder: (context, child) {
                double value = (index < currentStoryIndex)
                    ? 1
                    : (index == currentStoryIndex ? animController.value : 0);
                return LinearProgressIndicator(
                  value: value,
                  backgroundColor: Colors.white30,
                  valueColor: const AlwaysStoppedAnimation(ColorsDark.white),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
