import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/social/domain/entities/story_entity.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowMeViewsAndLikesBottomSheetStory extends StatelessWidget {
  const ShowMeViewsAndLikesBottomSheetStory({
    super.key,
    required this.onShowViewers,
    required this.story,
  });

  final VoidCallback onShowViewers;
  final StoryEntity story;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onShowViewers,
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.keyboard_arrow_up, color: ColorsDark.white),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.remove_red_eye,
                    color: ColorsDark.white, size: 20.sp),
                SizedBox(width: 4.w),
                CustomTextWidget(
                    text: '${story.viewers.length}',
                    textStyle:
                        TextStyle(color: ColorsDark.white, fontSize: 16.sp)),
                SizedBox(width: 20.w),
                Icon(Icons.favorite, color: Colors.red, size: 20.sp),
                SizedBox(width: 4.w),
                CustomTextWidget(
                    text: '${story.likes.length}',
                    textStyle:
                        TextStyle(color: ColorsDark.white, fontSize: 16.sp)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
