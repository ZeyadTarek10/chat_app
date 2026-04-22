import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:go_router/go_router.dart';

class RememberedPassword extends StatelessWidget {
  const RememberedPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: "Remembered password? ",
          textStyle: TextStyle(color: AppColors.mainTextColor, fontSize: 14),
        ),
        GestureDetector(
          onTap: () {
            GoRouter.of(context).pop();
          },
          child: Text(
            'Login to your account',
            style: TextStyle(
                color: AppColors.backgroundColorbuttonblue2,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}