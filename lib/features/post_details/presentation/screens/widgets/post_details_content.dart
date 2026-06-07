import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/post_details/presentation/screens/widgets/comment_item.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostDetailsContent extends StatelessWidget {
  const PostDetailsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: "Ana Caroline",
          textStyle: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontDetails.boldFontWeight,
            color: context.color.textColor,
          ),
        ),
        SizedBox(height: 15.h),
        RichText(
          text: TextSpan(
            style: TextStyle(
                fontSize: FontDetails.fontSizeS,
                color: context.color.textColor,
                height: 1.5),
            children: [
              const TextSpan(
                  text:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nibh pulvinar lectus ornare leo. Adipiscing ornare pellentesque aenean non. "),
              TextSpan(
                  text: "#paris #france #iloveit",
                  style: const TextStyle(color: ColorsDark.blueLight2),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      debugPrint('#paris #france #iloveit');
                    }),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        CustomTextWidget(
          text: "Posted 2hr ago",
          textStyle:
              TextStyle(fontSize: 12.sp, color: ColorsLight.mainTextColor),
        ),
        SizedBox(height: 25.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 5,
          itemBuilder: (context, index) {
            return const CommentItem(
              userName: "Lauren",
              comment: "Lorem ipsum dolor sit amet",
              imageUrl:
                  "https://i.pinimg.com/736x/79/64/c5/7964c5a700f0342abbb946e883b2a4f2.jpg",
            );
          },
        ),
      ],
    );
  }
}
