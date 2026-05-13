import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/core/validations/app_validation.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchCreateChateTextField extends StatelessWidget {
  const SearchCreateChateTextField(
      {super.key,
      required this.phoneController,
      required this.onChangedPicker,
      required this.onChangeTextField});

  final TextEditingController phoneController;
  final void Function(CountryCode) onChangedPicker;
  final void Function(String) onChangeTextField;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: CustomTextFormFieldWidget(
          controller: phoneController,
          hint: 'enter_phone_number'.tr(),
          withBorders: true,
          textInputType: TextInputType.phone,
          validator: (value) => AppValidator.phoneValidation(value),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 10.w, right: 5.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CountryCodePicker(
                   dialogBackgroundColor: context.color.navBarbg,
                  dialogTextStyle: TextStyle(color: context.color.textColor),
                  barrierColor: ColorsLight.mainTextColor,
                  headerTextStyle: TextStyle(color: context.color.textColor, fontWeight: FontDetails.boldFontWeight, fontSize: FontDetails.fontSizeM),
                  searchDecoration: const InputDecoration(
                    prefixIconColor: ColorsLight.hintColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorsLight.mainColor)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorsLight.mainTextColor)
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorsLight.mainTextColor),
                    ),
                  ),
                  onChanged: onChangedPicker,
                  initialSelection: 'EG',
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                  padding: EdgeInsets.zero,
                  flagWidth: 28.w,
                  textStyle: TextStyle(
                      color: ColorsLight.mainTextColor, fontSize: 16.sp),
                ),
                Icon(Icons.keyboard_arrow_down,
                    size: 18.sp, color: ColorsLight.mainTextColor),
                SizedBox(width: 5.w),
              ],
            ),
          ),
          onChange: onChangeTextField),
    );
  }
}
