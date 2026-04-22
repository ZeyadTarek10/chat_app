import 'package:chat_app/features/Login/presentation/manager/login_cubit/login_cubit.dart';
import 'package:chat_app/features/forget_password/presentation/manager/forget_password_cubit/forget_password_cubit.dart';
import 'package:chat_app/features/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:chat_app/features/Login/presentation/screens/login_screen.dart';
import 'package:chat_app/features/sign_up/presentation/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:chat_app/features/sign_up/presentation/screens/sign_up_screen.dart';
import 'package:chat_app/features/splash/presentation/views/onbording_screen.dart';
import 'package:chat_app/features/splash/presentation/views/splash_screen.dart';
import 'package:chat_app/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/first_feature/presentation/screens/feature_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String forgotPassword = '/forgotPassword';
  static const String signUp = '/signUp';
  static const String home = '/home';

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
          path: AppRoutes.splash,
          name: 'splash',
          builder: (context, state) => const SplashScreen()),
      GoRoute(
          path: AppRoutes.onboarding,
          name: 'onboarding',
          builder: (context, state) => const OnboardingScreen()),
      GoRoute(
          path: AppRoutes.login,
          name: 'login',
          builder: (context, state) {
            return BlocProvider(
              create: (context) => getIt<LoginCubit>(),
              child: const LoginScreen(),
            );
          }),
      GoRoute(
          path: AppRoutes.forgotPassword,
          name: 'forgotPassword',
          builder: (context, state) => BlocProvider(
                create: (context) => getIt<ForgetPasswordCubit>(),
                child: const ForgotPasswordScreen(),
              )),
      GoRoute(
          path: AppRoutes.signUp,
          name: 'signUp',
          builder: (context, state) => BlocProvider(
                create: (context) => getIt<SignUpCubit>(),
                child: const SignupScreen(),
              )),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
