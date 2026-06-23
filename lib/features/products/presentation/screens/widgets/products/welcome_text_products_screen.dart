import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeTextProductsScreen extends StatelessWidget {
  const WelcomeTextProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
            text: "hello".tr(),
            textStyle: TextStyle(
              fontSize: FontDetails.fontSizeXL, 
              fontWeight: FontDetails.blackFontWeight, 
              color: context.color.textColor,
            ),
          ),
          SizedBox(height: 5.h),
          CustomTextWidget(
            text: "welcome_to_app".tr(),
            textStyle: TextStyle(
              fontSize: FontDetails.fontSizeM, 
              color: ColorsLight.mainTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
