import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/sign_up/presentation/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:chat_app/shared_widgets/custom_loading.dart';
import 'package:chat_app/shared_widgets/show_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/features/Login/presentation/screens/widgets/button_sign_in_with_google.dart';
import 'package:chat_app/features/sign_up/presentation/screens/widgets/check_box_sign_up.dart';
import 'package:chat_app/features/sign_up/presentation/screens/widgets/divider_sign_up.dart';
import 'package:chat_app/features/sign_up/presentation/screens/widgets/form_sign_up.dart';
import 'package:chat_app/features/sign_up/presentation/screens/widgets/have_an_acount.dart';
import 'package:chat_app/shared_widgets/buttons/custom_linear_btn.dart';
import 'package:chat_app/shared_widgets/custom_app_bar.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late SignUpCubit signUpCubit;

  @override
  void initState() {
    super.initState();
    signUpCubit = context.read<SignUpCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    signUpCubit.nameController.dispose();
    signUpCubit.phoneController.dispose();
    signUpCubit.emailController.dispose();
    signUpCubit.passwordController.dispose();
    signUpCubit.confirmPasswordController.dispose();
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
          showSnackBar(context,
              text: 'signed_up_successfully'.tr(), color: Colors.green);
          GoRouter.of(context).pushReplacement(AppRoutes.home);
        } else if (state is SignUpFailure) {
          if (ModalRoute.of(context)?.isCurrent != true) {
            GoRouter.of(context).pop();
          }
          showSnackBar(context,
              text: state.errorMessage, color: Colors.redAccent);
        }
      },
      builder: (context, state) {
        return Form(
          key: signUpCubit.formKey,
          child: Scaffold(
            backgroundColor: context.color.mainColor,
            appBar: customAppBar(context),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10.h),
                    CustomTextWidget(
                      text: 'signup'.tr(),
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                        color: context.color.textColor,
                          fontSize: 28.sp,
                          fontWeight: FontDetails.boldFontWeight),
                    ),
                    SizedBox(height: 30.h),
                    const GoogleSignInButton(),
                    SizedBox(height: 30.h),
                    const DividerSignUp(),
                    SizedBox(height: 30.h),
                    FormSignUp(
                      nameController: signUpCubit.nameController,
                      phoneController: signUpCubit.phoneController,
                      emailController: signUpCubit.emailController,
                      passwordController: signUpCubit.passwordController,
                      confirmPasswordController: signUpCubit.confirmPasswordController,
                      isPasswordVisible: signUpCubit.isPasswordVisible,
                      togglePasswordVisibility: signUpCubit.togglePasswordVisibility,
                      onCountryCodeChanged: signUpCubit.updateCountryCode,
                    ),
                    SizedBox(height: 20.h),
                    CheckBoxSignUp(
                      value: signUpCubit.isTermsAccepted,
                      onChanged: signUpCubit.toggleTermsAcceptance,
                    ),
                    SizedBox(height: 24.h),
                    CustomLinearButton(
                      onPressed: () async {
                        if (signUpCubit.formKey.currentState!.validate()) {
                          signUpCubit.signUpUser(
                            name: signUpCubit.nameController.text.trim(),
                            phone: signUpCubit.phoneController.text.trim(),
                            email: signUpCubit.emailController.text.trim(),
                            password: signUpCubit.passwordController.text.trim(),
                          );
                        }
                      },
                      height: 50.h,
                      width: double.infinity.w,
                      child: CustomTextWidget(
                        text: 'signup'.tr(),
                        textStyle: TextStyle(
                          fontSize: FontDetails.fontSizeM,
                          color: Colors.white,
                          fontWeight: FontDetails.boldFontWeight,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    const HaveAnAcount(),
                    SizedBox(height: 20.h),
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
