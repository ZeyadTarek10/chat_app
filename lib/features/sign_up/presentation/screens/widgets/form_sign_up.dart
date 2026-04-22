import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/validations/app_validation.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';

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
  });
  
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isPasswordVisible;
  final Function() togglePasswordVisibility;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextWidget(
            textAlign: TextAlign.left,
            text: 'Full Name',
            textStyle: TextStyle(fontSize: 14, color: AppColors.mainTextColor)),
        const SizedBox(height: 8),
        CustomTextFormFieldWidget(
          controller: nameController,
          hint: 'Rhebhek',
          withBorders: true,
          textInputType: TextInputType.name,
          validator:(name) => AppValidator.nameValidation(name),
        ),
        const SizedBox(height: 20),

        CustomTextWidget(
            textAlign: TextAlign.left,
            text: 'Phone Number',
            textStyle: TextStyle(fontSize: 14, color: AppColors.mainTextColor)),
        const SizedBox(height: 8),
        CustomTextFormFieldWidget(
          controller: phoneController,
          hint: '+201000000000',
          withBorders: true,
          textInputType: TextInputType.phone,
          validator: (value) => AppValidator.phoneValidation(value),
        ),
        const SizedBox(height: 20),

        CustomTextWidget(
            textAlign: TextAlign.left,
            text: 'Email Address',
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
        
        CustomTextWidget(
            text: 'Password',
            textAlign: TextAlign.left,
            textStyle: TextStyle(fontSize: 14, color: AppColors.mainTextColor)),
        const SizedBox(height: 8),
        CustomTextFormFieldWidget(
          controller: passwordController,
          hint: '********',
          withBorders: true,
          obscureText: !isPasswordVisible,
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: AppColors.hintColor,
            ),
            onPressed: togglePasswordVisibility,
          ),
          validator: (value) => AppValidator.passwordValidation(value),
        ),
        const SizedBox(height: 20),
        
        CustomTextWidget(
            text: 'Confirm Password',
            textAlign: TextAlign.left,
            textStyle: TextStyle(fontSize: 14, color: AppColors.mainTextColor)),
        const SizedBox(height: 8),
        CustomTextFormFieldWidget(
          controller: confirmPasswordController,
          hint: '********',
          withBorders: true,
          obscureText: !isPasswordVisible,
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: AppColors.hintColor,
            ),
            onPressed: togglePasswordVisibility,
          ),
          validator: (value) {
            if (value != passwordController.text) {
              return 'Passwords do not match';
            }
            return AppValidator.passwordValidation(value);
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}