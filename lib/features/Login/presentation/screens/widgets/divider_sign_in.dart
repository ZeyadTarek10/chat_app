import 'package:flutter/material.dart';
import 'package:flutter_helper/core/utils/app_colors.dart';
import 'package:flutter_helper/shared_widgets/custom_text.dart';

class DividerSignIn extends StatelessWidget {
  const DividerSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.mainTextColor, thickness: 0.5)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomTextWidget(text: 'or sign in with', textStyle: TextStyle(color: AppColors.mainTextColor, fontSize: 12)),
        ),
        Expanded(child: Divider(color: AppColors.mainTextColor, thickness: 0.5)),
      ],
    );
  }
}