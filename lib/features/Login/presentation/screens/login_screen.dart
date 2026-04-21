import 'package:chat_app/shared_widgets/show_snack_bar.dart';
import 'package:chat_app/features/Login/presentation/manager/login_cubit/login_cubit.dart';
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
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;
  bool isKeepMeSignedIn = false;
  bool isLoading = false;

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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
          isLoading = true;
        } else if (state is LoginSuccess) {
          showSnackBar(context,
              text: 'Signed In Successfuly!.', color: Colors.green);
          GoRouter.of(context).push(AppRoutes.home);
        } else if (state is LoginFailure) {
          showSnackBar(context,
              text: state.errorMessage, color: Colors.redAccent);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 100),
                      const CustomTextWidget(
                        text: 'Login',
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
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
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<LoginCubit>(context).signInUser(
                                  email: emailController.text,
                                  password: passwordController.text, isKeepMeSignedIn: isKeepMeSignedIn);
                            }
                          },
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
            ),
          ),
        );
      },
    );
  }
}
