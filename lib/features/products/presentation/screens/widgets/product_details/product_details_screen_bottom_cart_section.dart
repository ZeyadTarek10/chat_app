import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/buttons/custom_linear_btn.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreenBottomCartSection extends StatelessWidget {
  const ProductDetailsScreenBottomCartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.color.mainColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                        text: "total_price".tr(),
                        textStyle: TextStyle(
                            fontWeight: FontDetails.boldFontWeight,
                            color: context.color.textColor,
                            fontSize: FontDetails.fontSizeM)),
                  ],
                ),
                CustomTextWidget(
                  text: "\$125",
                  textStyle: TextStyle(
                      fontWeight: FontDetails.boldFontWeight,
                      color: context.color.textColor,
                      fontSize: 18.sp),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 65.h,
            child: CustomLinearButton(
              radius: 0,
              onPressed: () {},
              child: CustomTextWidget(
                text: "chat_with_me".tr(),
                textStyle: TextStyle(
                    color: ColorsDark.white,
                    fontSize: FontDetails.fontSizeM,
                    fontWeight: FontDetails.boldFontWeight),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
