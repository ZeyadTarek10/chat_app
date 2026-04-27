import 'package:chat_app/core/utils/font_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckBoxSignUp extends StatelessWidget {
  const CheckBoxSignUp({super.key, required this.value, this.onChanged});

  final bool value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 24.h,
          width: 24.w,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF4ADE80),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
            side: BorderSide(color: AppColors.mainTextColor, width: 1.5.w),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: CustomTextWidget(
              text: 'by_creating_an_account_i_accept_hiring_hub_terms_of_use_and_privacy_policy'.tr(),
              textStyle: TextStyle(fontSize: FontDetails.fontSizeS, color: AppColors.mainTextColor)),
        ),
      ],
    );
  }
}
