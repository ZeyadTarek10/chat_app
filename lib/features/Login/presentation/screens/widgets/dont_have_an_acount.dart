import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:go_router/go_router.dart';

class DontHaveAnAcount extends StatelessWidget {
  const DontHaveAnAcount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextWidget(text: "dont_have_an_account".tr(),
            textStyle: TextStyle(color: AppColors.mainTextColor, fontSize: 14)),
        GestureDetector(
          onTap: () {
            GoRouter.of(context).push(AppRoutes.signUp);
          },
          child: CustomTextWidget(
            text: 'sign_up_here'.tr(),
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