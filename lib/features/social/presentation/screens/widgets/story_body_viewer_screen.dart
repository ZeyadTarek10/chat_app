import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/social/domain/entities/story_entity.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/image_story.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoryBodyViewerScreen extends StatelessWidget {
  const StoryBodyViewerScreen({
    super.key,
    required this.story,
  });

  final StoryEntity story;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Color(story.backgroundColor)),
        if (story.imageUrl != null)
          Positioned.fill(
            child: ImageStory(imageUrl: story.imageUrl!),
          ),
        if (story.imageUrl != null && story.text != null)
          Positioned.fill(
            child: Container(color: ColorsLight.black.withOpacity(0.3)),
          ),
        if (story.text != null)
          Center(
            child: CustomTextWidget(
              text: story.text!,
              textStyle: TextStyle(fontSize: 28.sp, color: ColorsDark.white),
            ),
          ),
      ],
    );
  }
}
