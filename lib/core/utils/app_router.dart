import 'package:amar_taka/features/auth/presentation/pages/splash_screen.dart';
import 'package:amar_taka/main.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      name: "home",
      builder: (context, state) => MyHomePage(title: "AmarTaka"),
    ),
  ],
);
}

