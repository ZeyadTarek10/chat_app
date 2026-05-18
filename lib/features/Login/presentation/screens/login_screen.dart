import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/services/animate_do.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_loading.dart';
import 'package:chat_app/shared_widgets/show_snack_bar.dart';
import 'package:chat_app/features/Login/presentation/manager/login_cubit/login_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/Login/presentation/screens/widgets/button_sign_in_with_google.dart';
import 'package:chat_app/features/Login/presentation/screens/widgets/divider_sign_in.dart';
import 'package:chat_app/features/Login/presentation/screens/widgets/dont_have_an_acount.dart';
import 'package:chat_app/features/Login/presentation/screens/widgets/form_login.dart';
import 'package:chat_app/features/Login/presentation/screens/widgets/kee_me_sign_in.dart';
import 'package:chat_app/shared_widgets/buttons/custom_linear_btn.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginCubit loginCubit;

  @override
  void initState() {
    super.initState();
    loginCubit = context.read<LoginCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    loginCubit.emailController.dispose();
    loginCubit.passwordController.dispose();
  }

//   Future<void> signInWithGoogle(BuildContext context) async {
//   try {
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     if (googleUser == null) return;

//     final GoogleSignInAuthentication googleAuth =
//         await googleUser.authentication;

//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     UserCredential userCredential =
//         await FirebaseAuth.instance.signInWithCredential(credential);

//     User? user = userCredential.user;

//     if (user != null && (user.displayName == null || user.displayName!.isEmpty)) {
//       await user.updateDisplayName(googleUser.displayName ?? "New User");
//       await user.reload();
//       user = FirebaseAuth.instance.currentUser;
//     }

//     Navigator.pushReplacementNamed(context, '/home');
//   } catch (e) {
//     buildAwesomeDialogError('Error', 'Google Sign-In failed: $e', context);
//   }
// }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const CustomLoading(),
          );
        } else if (state is LoginSuccess) {
          GoRouter.of(context).pop();
          showSnackBar(context,
              text: 'signed_in_successfuly'.tr(), color: Colors.green);
          GoRouter.of(context).pushReplacement(AppRoutes.home);
        } else if (state is LoginFailure) {
          if (ModalRoute.of(context)?.isCurrent != true) {
            GoRouter.of(context).pop();
          }
          showSnackBar(context,
              text: state.errorMessage, color: Colors.redAccent);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.color.mainColor,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: loginCubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 100.h),
                    CustomFadeInDown(
                      duration: 600,
                      child: CustomTextWidget(
                        text: 'login'.tr(),
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                            color: context.color.textColor,
                            fontSize: 28.sp,
                            fontWeight: FontDetails.boldFontWeight),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    const CustomFadeInDown(
                      duration: 300,
                      child: GoogleSignInButton(),
                    ),
                    SizedBox(height: 30.h),
                    const DividerSignIn(),
                    SizedBox(height: 30.h),
                    CustomFadeInLeft(
                      duration: 300,
                      child: FormLogin(
                          emailController: loginCubit.emailController,
                          passwordController: loginCubit.passwordController,
                          isPasswordVisible: loginCubit.isPasswordVisible,
                          togglePasswordVisibility:
                              loginCubit.togglePasswordVisibility),
                    ),
                    SizedBox(height: 10.h),
                    CustomFadeInRight(
                      duration: 300,
                      child: KeepMeSignIn(
                        value: loginCubit.isKeepMeSignedIn,
                        onChanged: loginCubit.toggleKeepMeSignedIn,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CustomFadeInUp(
                      duration: 300,
                      child: CustomLinearButton(
                          onPressed: () async {
                            if (loginCubit.formKey.currentState!.validate()) {
                              loginCubit.signInUser(
                                  email: loginCubit.emailController.text.trim(),
                                  password: loginCubit.passwordController.text.trim(),
                                  isKeepMeSignedIn: loginCubit.isKeepMeSignedIn);
                            }
                          },
                          height: 50.h,
                          width: double.infinity,
                          child: CustomTextWidget(
                              text: 'login'.tr(),
                              textStyle: TextStyle(
                                  fontSize: FontDetails.fontSizeM,
                                  color: ColorsDark.white,
                                  fontWeight: FontDetails.boldFontWeight))),
                    ),
                    SizedBox(height: 30.h),
                    const CustomFadeInUp(
                      duration: 600,
                      child: DontHaveAnAcount(),
                    ),
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
