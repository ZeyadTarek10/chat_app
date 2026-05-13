import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
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
        CustomTextWidget(text: "have_an_account".tr(),
            textStyle: TextStyle(color: ColorsLight.mainTextColor, fontSize: FontDetails.fontSizeS)),
        GestureDetector(
          onTap: () {
            GoRouter.of(context).pushReplacement(AppRoutes.login);
          },
          child: CustomTextWidget(
            text: 'sign_in_here'.tr(),
            textStyle: TextStyle(
                color: ColorsDark.blueLight2,
                fontSize: FontDetails.fontSizeS,
                fontWeight: FontDetails.boldFontWeight),
          ),
        ),
      ],
    );
  }
}