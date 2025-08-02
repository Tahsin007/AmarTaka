import 'package:amar_taka/main.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MyHomePage(title: "AmarTaka",),
    ),
  ],
);
}

