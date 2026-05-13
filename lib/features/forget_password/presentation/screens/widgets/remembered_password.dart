import 'package:chat_app/core/utils/font_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RememberedPassword extends StatelessWidget {
  const RememberedPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: "remembered_password".tr(),
          textStyle: TextStyle(color: ColorsLight.mainTextColor, fontSize: 14.sp),
        ),
        GestureDetector(
          onTap: () {
            GoRouter.of(context).pop();
          },
          child: Text(
            'login_to_your_account'.tr(),
            style: TextStyle(
                color: ColorsDark.blueLight2,
                fontSize: FontDetails.fontSizeS,
                fontWeight: FontDetails.semiBoldFontWeight),
          ),
        ),
      ],
    );
  }
}