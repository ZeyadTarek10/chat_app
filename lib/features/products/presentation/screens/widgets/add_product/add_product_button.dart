import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/buttons/custom_linear_btn.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddProductButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AddProductButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55.h,
      child: CustomLinearButton(
        onPressed: onPressed, 
        child: CustomTextWidget(
          text: "add_product".tr(),
          textStyle: TextStyle(
              color: ColorsDark.white, 
              fontSize: FontDetails.fontSizeM, 
              fontWeight: FontDetails.boldFontWeight),
        ),)
    );
  }
}
