import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DividerSignUp extends StatelessWidget {
  const DividerSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: ColorsLight.mainTextColor, thickness: 0.5.w)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: CustomTextWidget(text: 'or_sign_up_with'.tr(),
              textStyle: TextStyle(color: ColorsLight.mainTextColor, fontSize: FontDetails.fontSizeXS)),
        ),
        Expanded(child: Divider(color: ColorsLight.mainTextColor, thickness: 0.5.w)),
      ],
    );
  }
}