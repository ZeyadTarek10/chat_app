import 'package:flutter/material.dart';
import 'package:flutter_helper/core/utils/app_colors.dart';

class DividerSignUp extends StatelessWidget {
  const DividerSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.mainTextColor, thickness: 0.5)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('or sign up with',
              style: TextStyle(color: AppColors.mainTextColor, fontSize: 12)),
        ),
        Expanded(child: Divider(color: AppColors.mainTextColor, thickness: 0.5)),
      ],
    );
  }
}