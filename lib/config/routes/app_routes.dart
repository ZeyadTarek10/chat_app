import 'package:chat_app/features/forget_password/screens/forget_password_screen.dart';
import 'package:chat_app/features/Login/presentation/screens/login_screen.dart';
import 'package:chat_app/features/sign_up/presentation/screens/sign_up_screen.dart';
import 'package:chat_app/features/splash/presentation/views/onbording_screen.dart';
import 'package:chat_app/features/splash/presentation/views/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/first_feature/presentation/screens/feature_screen.dart';

class AppRoutes {
  static const String splash= '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String forgotPassword = '/forgotPassword';
  static const String signUp = '/signUp';
  static const String home = '/home';

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(path: AppRoutes.splash, name: 'splash', builder: (context, state) => const SplashScreen()),
      GoRoute(path: AppRoutes.onboarding, name: 'onboarding', builder: (context, state) => const OnboardingScreen()),
      GoRoute(path: AppRoutes.login, name: 'login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: AppRoutes.forgotPassword, name: 'forgotPassword', builder: (context, state) => const ForgotPasswordScreen()),
      GoRoute(path: AppRoutes.signUp, name: 'signUp', builder: (context, state) => const SignupScreen()),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
