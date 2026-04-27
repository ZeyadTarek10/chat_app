import 'package:chat_app/core/utils/font_details.dart';
import 'package:easy_localization/easy_localization.dart';
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
        Text("have_an_account".tr(),
            style: TextStyle(color: AppColors.mainTextColor, fontSize: FontDetails.fontSizeS)),
        GestureDetector(
          onTap: () {
            GoRouter.of(context).pushReplacement(AppRoutes.login);
          },
          child: Text(
            'sign_in_here'.tr(),
            style: TextStyle(
                color: AppColors.backgroundColorbuttonblue2,
                fontSize: FontDetails.fontSizeS,
                fontWeight: FontDetails.boldFontWeight),
          ),
        ),
      ],
    );
  }
}