import 'package:chat_app/core/utils/font_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_images.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Image.asset(
        AppImages.googleLogoImg,
        height: 24.h,
      ),
      label: CustomTextWidget(
       text:  'sign_in_with_google'.tr(),
        textStyle: TextStyle(color: ColorsLight.mainTextColor, fontSize: FontDetails.fontSizeM, fontWeight: FontDetails.mediumFontWeight),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: ColorsDark.googlebtnColor,
        side: BorderSide.none,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    );
  }
}