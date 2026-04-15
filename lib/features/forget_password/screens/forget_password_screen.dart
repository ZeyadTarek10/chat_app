import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/validations/app_validation.dart';
import 'package:chat_app/features/forget_password/screens/widgets/remembered_password.dart';
import 'package:chat_app/shared_widgets/buttons/custom_linear_btn.dart';
import 'package:chat_app/shared_widgets/custom_app_bar.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: customAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const CustomTextWidget(
                text: 'Forgot Password',
                textStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 12),
              const CustomTextWidget(
                text:
                    "Enter the email address registered with your account. We'll send you a link to reset your password.",
                textStyle:
                    TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
              ),
              const SizedBox(height: 40),
              CustomTextFormFieldWidget(
                controller: emailController,
                hint: 'Rhebhek@gmail.com',
                withBorders: true,
                textInputType: TextInputType.emailAddress,
                validator: (value) => AppValidator.emailValidation(value),
              ),
              const SizedBox(height: 30),
              CustomLinearButton(
                  onPressed: () {},
                  height: 50,
                  width: double.infinity,
                  child: CustomTextWidget(
                      text: 'Submit',
                      textStyle: TextStyle(
                          fontSize: 16,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold))),
              const SizedBox(height: 24),
              const RememberedPassword(),
            ],
          ),
        ),
      ),
    );
  }
}