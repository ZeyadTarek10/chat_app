import 'package:go_router/go_router.dart';

import '../../features/first_feature/presentation/screens/feature_screen.dart';

class AppRoutes {
  static const String home = '/';

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
