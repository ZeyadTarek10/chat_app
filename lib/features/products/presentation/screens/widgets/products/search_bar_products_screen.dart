import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/validations/app_validation.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarProductsScreen extends StatelessWidget {
  const SearchBarProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                color: ColorsLight.mainTextColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: CustomTextFormFieldWidget(
                prefixIcon: const Icon(Icons.search, color: ColorsLight.hintColor,),
                hint: "search".tr(), 
                hintColor: ColorsLight.hintColor,
                validator: (String? value){
                  return AppValidator.noValidation();
                },
              )
            ),
          ),
          SizedBox(width: 15.w),
          Container(
            padding: EdgeInsets.all(15.r),
            decoration: BoxDecoration(
              color: ColorsDark.blueLight1, 
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: const Icon(Icons.mic_none, color: ColorsDark.white),
          ),
        ],
      ),
    );
  }
}
