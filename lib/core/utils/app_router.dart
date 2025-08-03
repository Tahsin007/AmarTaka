import 'package:amar_taka/features/auth/presentation/pages/login.dart';
import 'package:amar_taka/features/auth/presentation/pages/onbaording.dart';
import 'package:amar_taka/features/auth/presentation/pages/signup.dart';
import 'package:amar_taka/features/auth/presentation/pages/splash_screen.dart';
import 'package:amar_taka/main.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter createRouter(String initialRoute) {
    return GoRouter(
      initialLocation: initialRoute,
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
        GoRoute(
          path: '/onboard',
          name: "onboard",
          builder: (context, state) => OnboardingScreen(),
        ),
        GoRoute(
          path: '/signin',
          name: "signin",
          builder: (context, state) => SignInScreen(),
        ),
        GoRoute(
          path: '/signup',
          name: "signup",
          builder: (context, state) => SignUpScreen(),
        ),
      ],
    );
  }
}

