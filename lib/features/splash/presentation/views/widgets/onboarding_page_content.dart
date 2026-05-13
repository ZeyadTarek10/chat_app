import 'package:chat_app/core/utils/font_details.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/splash/data/onboarding_model.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPageContent extends StatelessWidget {
  final OnboardingModel model;

  const OnboardingPageContent({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            model.imagePath,
            height: 200.h,
            width: 200.w,
          ),
          SizedBox(height: 40.h),
          CustomTextWidget(
            text: model.title,
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontDetails.boldFontWeight,
              color: ColorsDark.blueDark,
            ),
          ),
          SizedBox(height: 16.h),
          CustomTextWidget(
            text: model.description,
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              fontSize: FontDetails.fontSizeS,
              color: ColorsDark.blueDark.withOpacity(0.7),
              height: 1.5.h,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
