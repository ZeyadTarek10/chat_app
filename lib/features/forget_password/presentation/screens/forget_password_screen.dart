import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/forget_password/presentation/manager/forget_password_cubit/forget_password_cubit.dart';
import 'package:chat_app/shared_widgets/custom_loading.dart';
import 'package:chat_app/shared_widgets/show_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/validations/app_validation.dart';
import 'package:chat_app/features/forget_password/presentation/screens/widgets/remembered_password.dart';
import 'package:chat_app/shared_widgets/buttons/custom_linear_btn.dart';
import 'package:chat_app/shared_widgets/custom_app_bar.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            text: 'password_reset_email_sent_successfully'.tr(),
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
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    CustomTextWidget(
                      text: 'forgot_password'.tr(),
                      textStyle: TextStyle(
                          fontSize: FontDetails.fontSizeL,
                          fontWeight: FontDetails.boldFontWeight,
                          color: AppColors.black),
                    ),
                    SizedBox(height: 12.h),
                    CustomTextWidget(
                      text:
                          "enter_the_email_address_registered_with_your_account_Well_send_you_a_link_to_reset_your_password".tr(),
                      textStyle: TextStyle(
                          fontSize: FontDetails.fontSizeS, color: AppColors.mainTextColor, height: 1.5.h),
                    ),
                    SizedBox(height: 40.h),
                    CustomTextFormFieldWidget(
                      controller: emailController,
                      hint: 'Rhebhek@gmail.com',
                      withBorders: true,
                      textInputType: TextInputType.emailAddress,
                      validator: (value) =>
                          AppValidator.emailValidation(value),
                    ),
                    SizedBox(height: 30.h),
                    CustomLinearButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<ForgetPasswordCubit>(context)
                                .resetPassword(
                              email: emailController.text.trim(),
                            );
                          }
                        },
                        height: 50.h,
                        width: double.infinity.w,
                        child: CustomTextWidget(
                            text: 'submit'.tr(),
                            textStyle: TextStyle(
                                fontSize: FontDetails.fontSizeM,
                                color: AppColors.white,
                                fontWeight: FontDetails.boldFontWeight))),
                    SizedBox(height: 24.h),
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
