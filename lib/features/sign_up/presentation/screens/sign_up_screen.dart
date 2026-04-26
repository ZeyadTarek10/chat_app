import 'package:chat_app/features/sign_up/presentation/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:chat_app/shared_widgets/custom_loading.dart';
import 'package:chat_app/shared_widgets/show_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const CustomLoading(),
          );
        } else if (state is SignUpSuccess) {
          GoRouter.of(context).pop(); 
          showSnackBar(context, text: 'signed_up_successfully'.tr(), color: Colors.green);
          GoRouter.of(context).pushReplacement(AppRoutes.home);
        } else if (state is SignUpFailure) {
          if (ModalRoute.of(context)?.isCurrent != true) {
          GoRouter.of(context).pop();
          }
          showSnackBar(context, text: state.errorMessage, color: Colors.redAccent);
        }
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<SignUpCubit>(context);
        return Form(
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
                    CustomTextWidget(
                      text: 'signup'.tr(),
                      textAlign: TextAlign.center,
                      textStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    const GoogleSignInButton(),
                    const SizedBox(height: 30),
                    const DividerSignUp(),
                    const SizedBox(height: 30),
                    
                    FormSignUp(
                      nameController: nameController,
                      phoneController: phoneController,
                      emailController: emailController,
                      passwordController: passwordController,
                      confirmPasswordController: confirmPasswordController,
                      isPasswordVisible: cubit.isPasswordVisible, 
                      togglePasswordVisibility: cubit.togglePasswordVisibility, 
                    ),
                    
                    const SizedBox(height: 20),
                    
                    CheckBoxSignUp(
                      value: cubit.isTermsAccepted,
                      onChanged: cubit.toggleTermsAcceptance, 
                    ),
                    
                    const SizedBox(height: 24),
                    CustomLinearButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          cubit.signUpUser(
                            name: nameController.text.trim(),
                            phone: phoneController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                        }
                      },
                      height: 50,
                      width: double.infinity,
                      child: CustomTextWidget(
                        text: 'signup'.tr(),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const HaveAnAcount(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}