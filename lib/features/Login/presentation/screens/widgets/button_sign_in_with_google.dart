import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/sign_up/presentation/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:chat_app/shared_widgets/custom_loading.dart';
import 'package:chat_app/shared_widgets/show_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_images.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading || state is GoogleSignInLoading){
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const CustomLoading(), 
          );
        } else if (state is SignUpSuccess || state is GoogleSignInSuccess) {
          if (GoRouter.of(context).canPop()) {
            GoRouter.of(context).pop();
          }
          showSnackBar(context,
              text: 'signed_in_successfuly'.tr(), color: Colors.green);
          GoRouter.of(context).pushReplacement(AppRoutes.home);
        } else if (state is GoogleSignInFailure) {
          if (GoRouter.of(context).canPop()) {
            GoRouter.of(context).pop();
          }
          showSnackBar(context,
              text: state.errorMessage, color: ColorsLight.error);
        } else if (state is SignUpFailure) {
          if (GoRouter.of(context).canPop()) {
            GoRouter.of(context).pop();
          }
          showSnackBar(context,
              text: state.errorMessage, color: ColorsLight.error);
        }
      },
      child: OutlinedButton.icon(
        onPressed: () {
          context.read<SignUpCubit>().signInWithGoogle();
        },
        icon: Image.asset(
          AppImages.googleLogoImg,
          height: 24.h,
        ),
        label: CustomTextWidget(
          text: 'sign_in_with_google'.tr(),
          textStyle: TextStyle(
              color: ColorsLight.mainTextColor,
              fontSize: FontDetails.fontSizeM,
              fontWeight: FontDetails.mediumFontWeight),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: ColorsDark.googlebtnColor,
          side: BorderSide.none,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      ),
    );
  }
}
