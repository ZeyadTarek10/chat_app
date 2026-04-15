import 'package:flutter/material.dart';
import 'package:flutter_helper/core/utils/app_colors.dart';
import 'package:flutter_helper/core/utils/app_images.dart';
import 'package:flutter_helper/shared_widgets/custom_text.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Image.asset(
        '${AppImages.googleLogoImg}google_logo.png',
        height: 24,
      ),
      label: CustomTextWidget(
       text:  'Sign in with Google',
        textStyle: TextStyle(color: AppColors.mainTextColor, fontSize: 16, fontWeight: FontWeight.w500),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.googlebtnColor,
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}