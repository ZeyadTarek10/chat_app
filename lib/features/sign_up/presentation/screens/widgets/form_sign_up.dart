import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/validations/app_validation.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormSignUp extends StatelessWidget {
  const FormSignUp({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isPasswordVisible,
    required this.togglePasswordVisibility,
    // required this.selectedCountryCode,
    required this.onCountryCodeChanged,
  });
  
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  // final String selectedCountryCode;
  final bool isPasswordVisible;
  final Function() togglePasswordVisibility;
  final Function(String) onCountryCodeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextWidget(
            textAlign: TextAlign.left,
            text: 'full_name'.tr(),
            textStyle: TextStyle(fontSize: FontDetails.fontSizeS, color: ColorsLight.mainTextColor)),
        SizedBox(height: 8.h),
        CustomTextFormFieldWidget(
          controller: nameController,
          hint: 'Rhebhek',
          withBorders: true,
          textInputType: TextInputType.name,
          validator:(name) => AppValidator.nameValidation(name),
        ),
        SizedBox(height: 20.h),

        CustomTextWidget(
            textAlign: TextAlign.left,
            text: 'phone_number'.tr(),
            textStyle: TextStyle(fontSize: FontDetails.fontSizeS, color: ColorsLight.mainTextColor)),
        SizedBox(height: 8.h),
        CustomTextFormFieldWidget(
          controller: phoneController,
          hint: '1000000000',
          withBorders: true,
          textInputType: TextInputType.phone,
          validator: (value) => AppValidator.phoneValidation(value),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CountryCodePicker(
                  // backgroundColor: context.color.mainColor!.withOpacity(0.5),
                  dialogBackgroundColor: context.color.navBarbg,
                  dialogTextStyle: TextStyle(color: context.color.textColor),
                  barrierColor: ColorsLight.mainTextColor,
                  headerTextStyle: TextStyle(color: context.color.textColor, fontWeight: FontDetails.boldFontWeight, fontSize: FontDetails.fontSizeM),
                  searchDecoration: const InputDecoration(
                    prefixIconColor: Color.fromARGB(149, 0, 0, 0),
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
                  onChanged: (CountryCode countryCode) {
                    onCountryCodeChanged(countryCode.dialCode ?? '+20');
                  },
                  initialSelection: 'EG', 
                  favorite: const ['+20', 'EG', '+44', 'GB'], 
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                  padding: EdgeInsets.zero,
                  flagWidth: 24.w,
                  textStyle: TextStyle(color: ColorsLight.mainTextColor, fontSize: 14.sp),
                ),
                Icon(Icons.keyboard_arrow_down, size: 20.sp, color: ColorsLight.mainTextColor),
                SizedBox(width: 4.w),
                Container(
                  height: 24.h,
                  width: 1.w,
                  color: ColorsLight.mainTextColor.withOpacity(0.5),
                ),
                SizedBox(width: 8.w),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.h),

        CustomTextWidget(
            textAlign: TextAlign.left,
            text: 'email_address'.tr(),
            textStyle: TextStyle(fontSize: FontDetails.fontSizeS, color: ColorsLight.mainTextColor)),
        SizedBox(height: 8.h),
        CustomTextFormFieldWidget(
          controller: emailController,
          hint: 'Rhebhek@gmail.com',
          withBorders: true,
          textInputType: TextInputType.emailAddress,
          validator: (value) => AppValidator.emailValidation(value),
        ),
        SizedBox(height: 20.h),
        
        CustomTextWidget(
            text: 'password'.tr(),
            textAlign: TextAlign.left,
            textStyle: TextStyle(fontSize: FontDetails.fontSizeS, color: ColorsLight.mainTextColor)),
        SizedBox(height: 8.h),
        CustomTextFormFieldWidget(
          controller: passwordController,
          hint: '********',
          withBorders: true,
          obscureText: !isPasswordVisible,
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: ColorsLight.hintColor,
            ),
            onPressed: togglePasswordVisibility,
          ),
          validator: (value) => AppValidator.passwordValidation(value),
        ),
        SizedBox(height: 20.h),
        
        CustomTextWidget(
            text: 'confirm_password'.tr(),
            textAlign: TextAlign.left,
            textStyle: TextStyle(fontSize: FontDetails.fontSizeS, color: ColorsLight.mainTextColor)),
        SizedBox(height: 8.h),
        CustomTextFormFieldWidget(
          controller: confirmPasswordController,
          hint: '********',
          withBorders: true,
          obscureText: !isPasswordVisible,
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: ColorsLight.hintColor,
            ),
            onPressed: togglePasswordVisibility,
          ),
          validator: (value) {
            if (value != passwordController.text) {
              return 'passwords_do_not_match'.tr();
            }
            return AppValidator.passwordValidation(value);
          },
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}