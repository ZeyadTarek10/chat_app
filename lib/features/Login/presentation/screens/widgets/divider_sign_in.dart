import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';

class DividerSignIn extends StatelessWidget {
  const DividerSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.mainTextColor, thickness: 0.5)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomTextWidget(text: 'or_sign_in_with'.tr(), textStyle: TextStyle(color: AppColors.mainTextColor, fontSize: 12)),
        ),
        Expanded(child: Divider(color: AppColors.mainTextColor, thickness: 0.5)),
      ],
    );
  }
}