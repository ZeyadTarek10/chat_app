import 'package:chat_app/shared_widgets/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/Login/presentation/screens/widgets/button_sign_in_with_google.dart';
import 'package:chat_app/features/sign_up/presentation/screens/widgets/check_box_sign_up.dart';
import 'package:chat_app/features/sign_up/presentation/screens/widgets/divider_sign_up.dart';
import 'package:chat_app/features/sign_up/presentation/screens/widgets/form_sign_up.dart';
import 'package:chat_app/features/sign_up/presentation/screens/widgets/have_an_acount.dart';
import 'package:chat_app/shared_widgets/buttons/custom_linear_btn.dart';
import 'package:chat_app/shared_widgets/custom_app_bar.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
  final formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;
  bool isSignedUp = false;
  bool isLoading = false;

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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Form(
        key: formKey,
        child: Scaffold(
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
                    textStyle:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
                      onPressed: () async {
                        await validateAndSignUp(context);
                      },
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
        ),
      ),
    );
  }

  Future<void> validateAndSignUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        showSnackBar(context,
            text: 'Account Created Successfuly', color: Colors.green);
        GoRouter.of(context).pushReplacement(AppRoutes.home);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showSnackBar(context,
              text: 'The password provided is too weak.', color: Colors.red);
        } else if (e.code == 'email-already-in-use') {
          showSnackBar(context,
              text: 'The account already exists for that email.',
              color: Colors.red);
        }
      } catch (e) {
        showSnackBar(context, text: 'there was an error.', color: Colors.red);
      }
      isLoading = false;
      setState(() {
        
      });
    }
  }
}
