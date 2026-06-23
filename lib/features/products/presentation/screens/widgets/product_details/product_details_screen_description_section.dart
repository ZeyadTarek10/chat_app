import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDescriptionSection extends StatelessWidget {
  const ProductDescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: "description".tr(),
            textStyle: TextStyle(
              fontSize: FontDetails.fontSizeM, 
              color: context.color.textColor,
              fontWeight: FontDetails.boldFontWeight)),
        SizedBox(height: 10.h),
        RichText(
          text: TextSpan(
            style: TextStyle(
                color: ColorsLight.mainTextColor, height: 1.5.h, fontSize: FontDetails.fontSizeS),
            children: [
              const TextSpan(
                  text:
                      "The Nike Throwback Pullover Hoodie is made from premium French terry fabric that blends a performance feel with "),
              TextSpan(
                text: "read_more".tr(),
                style: TextStyle(
                    color: context.color.textColor, fontWeight: FontDetails.boldFontWeight),
              ),
            ],
          ),
        ),
      ],
    );
  }
}