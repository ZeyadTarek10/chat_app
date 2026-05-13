import 'package:chat_app/core/utils/font_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/validations/app_validation.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class FormLogin extends StatelessWidget {
  const FormLogin(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.isPasswordVisible,
      required this.togglePasswordVisibility});
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final Function() togglePasswordVisibility;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextWidget(text: 'email_address'.tr(), textAlign: TextAlign.start,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextWidget(text: 'password'.tr(),
                textStyle: TextStyle(fontSize: FontDetails.fontSizeS, color: ColorsLight.mainTextColor)),
            GestureDetector(
              onTap: () {
                GoRouter.of(context).push(AppRoutes.forgotPassword);
              },
              child: CustomTextWidget(
                text: 'forgot_password'.tr(),
                textStyle: TextStyle(
                    color: ColorsDark.blueLight2,
                    fontSize: FontDetails.fontSizeXS,
                    fontWeight: FontDetails.boldFontWeight),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        CustomTextFormFieldWidget(
          controller: passwordController,
          hint: '********',
          withBorders: true,
          obscureText: !isPasswordVisible,
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: ColorsLight.hintColor,
            ),
            onPressed: togglePasswordVisibility,
          ),
          validator: (value) => AppValidator.passwordValidation(value),
        ),
      ],
    );
  }
}
