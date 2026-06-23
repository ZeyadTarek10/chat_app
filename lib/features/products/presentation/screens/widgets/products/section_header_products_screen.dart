import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/buttons/custom_text_btn.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionHeaderProductsScreen extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;
  
  const SectionHeaderProductsScreen({super.key, required this.title, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextWidget(
            text: title,
            textStyle: TextStyle(
              fontSize: 18.sp, 
              fontWeight: FontDetails.blackFontWeight, 
              color: context.color.textColor,
            ),
          ),
          CustomTextButtonWidget(
            text: "view_all".tr(), 
            textStyle: const TextStyle(
              color: ColorsLight.mainTextColor
            ),
            onPressed: onViewAll
          ),
        ],
      ),
    );
  }
}
