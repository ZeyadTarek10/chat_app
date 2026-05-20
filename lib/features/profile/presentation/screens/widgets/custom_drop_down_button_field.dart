import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownButtonFormField extends StatelessWidget {
  const CustomDropDownButtonFormField({
    super.key,
    required this.genderController,
  });

  final TextEditingController genderController;

  @override
  Widget build(BuildContext context) {
    final List<String> genderOptions = ['male'.tr(), 'female'.tr()];

    String? initialValue;
    if (genderController.text.isNotEmpty && genderOptions.contains(genderController.text)) {
      initialValue = genderController.text;
    }

    return DropdownButtonFormField<String>(
      value: initialValue, 
      dropdownColor: context.color.navBarbg,
      icon: const Icon(Icons.keyboard_arrow_down, color: ColorsLight.mainTextColor), 
      decoration: InputDecoration(
        hintText: 'Select Gender',
        hintStyle: TextStyle(color: context.color.textColor), 
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorsDark.blueDark, width: 0.5.w),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorsDark.blueDark, width: 0.5.w),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      items: genderOptions.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: CustomTextWidget(
            text: value,
            textStyle: TextStyle(fontSize: 16.sp, color: context.color.textColor),
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        if (newValue != null) {
          genderController.text = newValue;
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please_select_your_gender'.tr();
        }
        return null;
      },
    );
  }
}