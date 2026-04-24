import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/splash/data/onboarding_model.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';

class OnboardingPageContent extends StatelessWidget {
  final OnboardingModel model;

  const OnboardingPageContent({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            model.imagePath,
            height: 200,
            width: 200,
          ),
          const SizedBox(height: 40),
          CustomTextWidget(
            text: model.title,
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.mainColor,
            ),
          ),
          const SizedBox(height: 16),
          CustomTextWidget(
            text: model.description,
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              fontSize: 14,
              color: AppColors.mainColor.withOpacity(0.7),
              height: 1.5,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
