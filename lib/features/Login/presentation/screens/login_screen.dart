import 'package:flutter/material.dart';
import 'package:flutter_helper/config/routes/app_routes.dart';
import 'package:flutter_helper/core/utils/app_colors.dart';
import 'package:flutter_helper/features/Login/presentation/screens/widgets/button_sign_in_with_google.dart';
import 'package:flutter_helper/features/Login/presentation/screens/widgets/divider_sign_in.dart';
import 'package:flutter_helper/features/Login/presentation/screens/widgets/dont_have_an_acount.dart';
import 'package:flutter_helper/features/Login/presentation/screens/widgets/form_login.dart';
import 'package:flutter_helper/features/Login/presentation/screens/widgets/kee_me_sign_in.dart';
import 'package:flutter_helper/shared_widgets/buttons/custom_linear_btn.dart';
import 'package:flutter_helper/shared_widgets/custom_text.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isKeepMeSignedIn = false;
  String? emailError;
  String? passwordError;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void toggleKeepMeSignedIn(bool? value) {
    setState(() {
      isKeepMeSignedIn = value ?? false;
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100),
              const CustomTextWidget(
                text: 'Login',
                textAlign: TextAlign.center,
                textStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              const GoogleSignInButton(),
              const SizedBox(height: 30),
              const DividerSignIn(),
              const SizedBox(height: 30),
              FormLogin(
                  emailController: emailController,
                  passwordController: passwordController,
                  isPasswordVisible: isPasswordVisible,
                  togglePasswordVisibility: togglePasswordVisibility),
              const SizedBox(height: 10),
              KeepMeSignIn(
                value: isKeepMeSignedIn,
                onChanged: toggleKeepMeSignedIn,
              ),
              const SizedBox(height: 20),
              CustomLinearButton(
                  onPressed: validateAndLogin,
                  height: 50,
                  width: double.infinity,
                  child: CustomTextWidget(
                      text: 'Login',
                      textStyle: TextStyle(
                          fontSize: 16,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold))),
              const SizedBox(height: 30),
              const DontHaveAnAcount(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}



