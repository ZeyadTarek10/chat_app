import 'package:flutter/material.dart';
import 'package:flutter_helper/config/routes/app_routes.dart';
import 'package:flutter_helper/core/utils/app_colors.dart';
import 'package:flutter_helper/features/Login/presentation/screens/widgets/button_sign_in_with_google.dart';
import 'package:flutter_helper/features/sign_up/presentation/screens/widgets/check_box_sign_up.dart';
import 'package:flutter_helper/features/sign_up/presentation/screens/widgets/divider_sign_up.dart';
import 'package:flutter_helper/features/sign_up/presentation/screens/widgets/form_sign_up.dart';
import 'package:flutter_helper/features/sign_up/presentation/screens/widgets/have_an_acount.dart';
import 'package:flutter_helper/shared_widgets/buttons/custom_linear_btn.dart';
import 'package:flutter_helper/shared_widgets/custom_app_bar.dart';
import 'package:flutter_helper/shared_widgets/custom_text.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isPasswordVisible = false;
  bool isSignedUp = false;
  String? emailError;
  String? passwordError;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void toggleSignUp(bool? value) {
    setState(() {
      isSignedUp = value ?? false;
    });
  }

  void validateAndLogin() {
    bool hasError = false;
    if (!hasError) {
      GoRouter.of(context).pushReplacement(AppRoutes.home);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: customAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              const CustomTextWidget(
                text: 'Signup',
                textAlign: TextAlign.center,
                textStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const GoogleSignInButton(),
              const SizedBox(height: 30),
              const DividerSignUp(),
              const SizedBox(height: 30),
              FormSignUp(
                emailController: emailController,
                passwordController: passwordController,
                isPasswordVisible: isPasswordVisible,
                togglePasswordVisibility: togglePasswordVisibility,
                confirmPasswordController: confirmPasswordController,
              ),
              const SizedBox(height: 20),
              CheckBoxSignUp(
                value: isSignedUp,
                onChanged: toggleSignUp,
              ),
              const SizedBox(height: 24),
              CustomLinearButton(
                  onPressed: validateAndLogin,
                  height: 50,
                  width: double.infinity,
                  child: CustomTextWidget(
                      text: 'Signup',
                      textStyle: TextStyle(
                          fontSize: 16,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold))),
              const SizedBox(height: 30),
              const HaveAnAcount(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
