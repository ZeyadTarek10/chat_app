import '../../features/first_feature/presentation/screens/feature_screen.dart';

class AppRoutes {
  static String homeScreenRoute = 'homeScreen';

  static get routes {
    return {
      AppRoutes.homeScreenRoute: (context) => const HomeScreen(),
    };
  }
}
