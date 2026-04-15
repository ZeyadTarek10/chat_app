import 'package:flutter/material.dart';
import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:go_router/go_router.dart';

class HaveAnAcount extends StatelessWidget {
  const HaveAnAcount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Have an Account? ",
            style: TextStyle(color: AppColors.mainTextColor, fontSize: 14)),
        GestureDetector(
          onTap: () {
            GoRouter.of(context).pushReplacement(AppRoutes.login);
          },
          child: Text(
            'Sign in here',
            style: TextStyle(
                color: AppColors.mainColor,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}