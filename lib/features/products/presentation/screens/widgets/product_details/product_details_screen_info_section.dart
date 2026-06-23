import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
              text: "Men's Printed Pullover Hoodie",
              textStyle: TextStyle(
                  color: ColorsLight.mainTextColor,
                  fontWeight: FontDetails.regularFontWeight,
                  fontSize: FontDetails.fontSizeXS),
            ),
            SizedBox(height: 5.h),
            CustomTextWidget(
              text: "Nike Club Fleece",
              textStyle: TextStyle(
                  fontSize: FontDetails.fontSizeL,
                  fontWeight: FontDetails.boldFontWeight,
                  color: context.color.textColor),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
              text: "price".tr(),
              textStyle: TextStyle(
                  color: ColorsLight.mainTextColor,
                  fontWeight: FontDetails.regularFontWeight,
                  fontSize: FontDetails.fontSizeXS),
            ),
            SizedBox(height: 5.h),
            CustomTextWidget(
              text: "\$120",
              textStyle: TextStyle(
                  fontSize: FontDetails.fontSizeL,
                  fontWeight: FontDetails.boldFontWeight,
                  color: context.color.textColor),
            ),
          ],
        ),
      ],
    );
  }
}