import 'package:flutter/material.dart';
import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/validations/app_validation.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
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
        CustomTextWidget(text: 'Email Address', textAlign: TextAlign.start,
            textStyle: TextStyle(fontSize: 14, color: AppColors.mainTextColor)),
        const SizedBox(height: 8),
        CustomTextFormFieldWidget(
          controller: emailController,
          hint: 'Rhebhek@gmail.com',
          withBorders: true,
          textInputType: TextInputType.emailAddress,
          validator: (value) => AppValidator.emailValidation(value),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextWidget(text: 'Password',
                textStyle: TextStyle(fontSize: 14, color: AppColors.mainTextColor)),
            GestureDetector(
              onTap: () {
                GoRouter.of(context).push(AppRoutes.forgotPassword);
              },
              child: CustomTextWidget(
                text: 'Forgot Password',
                textStyle: TextStyle(
                    color: AppColors.backgroundColorbuttonblue2,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
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
              color: AppColors.hintColor,
            ),
            onPressed: togglePasswordVisibility,
          ),
          validator: (value) => AppValidator.passwordValidation(value),
        ),
      ],
    );
  }
}
