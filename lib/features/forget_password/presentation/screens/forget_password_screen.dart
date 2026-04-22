import 'package:chat_app/features/forget_password/presentation/manager/forget_password_cubit/forget_password_cubit.dart';
import 'package:chat_app/shared_widgets/custom_loading.dart';
import 'package:chat_app/shared_widgets/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/validations/app_validation.dart';
import 'package:chat_app/features/forget_password/presentation/screens/widgets/remembered_password.dart';
import 'package:chat_app/shared_widgets/buttons/custom_linear_btn.dart';
import 'package:chat_app/shared_widgets/custom_app_bar.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const CustomLoading(),
          );
        }
        if (state is ForgetPasswordSuccess) {
          GoRouter.of(context).pop(); 
          showSnackBar(
            context,
            color: Colors.green,
            text: 'Password reset email sent successfully.',
          );
          GoRouter.of(context).pop();
        } else if (state is ForgetPasswordFailure) {
          if (ModalRoute.of(context)?.isCurrent != true) {
          GoRouter.of(context).pop();
          }
          showSnackBar(
            context,
            color: Colors.red,
            text: state.errorMessage,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: customAppBar(context),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: formKey,
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
                      textStyle: TextStyle(
                          fontSize: 14, color: Colors.grey, height: 1.5),
                    ),
                    const SizedBox(height: 40),
                    CustomTextFormFieldWidget(
                      controller: emailController,
                      hint: 'Rhebhek@gmail.com',
                      withBorders: true,
                      textInputType: TextInputType.emailAddress,
                      validator: (value) =>
                          AppValidator.emailValidation(value),
                    ),
                    const SizedBox(height: 30),
                    CustomLinearButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<ForgetPasswordCubit>(context)
                                .resetPassword(
                              email: emailController.text.trim(),
                            );
                          }
                        },
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
          ),
        );
      },
    );
  }
}
