import 'package:flutter/material.dart';
import 'package:flutter_helper/config/routes/app_routes.dart';
import 'package:flutter_helper/core/utils/app_colors.dart';
import 'package:flutter_helper/shared_widgets/custom_text.dart';
import 'package:go_router/go_router.dart';

class DontHaveAnAcount extends StatelessWidget {
  const DontHaveAnAcount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextWidget(text: "Don't have an Account? ",
            textStyle: TextStyle(color: AppColors.mainTextColor, fontSize: 14)),
        GestureDetector(
          onTap: () {
            GoRouter.of(context).push(AppRoutes.signUp);
          },
          child: CustomTextWidget(
            text: 'Sign up here',
            textStyle: TextStyle(
                color: AppColors.backgroundColorbuttonblue2,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}