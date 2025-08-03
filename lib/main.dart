import 'package:amar_taka/core/theme/app_theme.dart';
import 'package:amar_taka/core/utils/app_router.dart';
import 'package:amar_taka/features/auth/domain/repositories/auth_repository.dart';
import 'package:amar_taka/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:amar_taka/features/auth/presentation/bloc/auth_event.dart';
import 'package:amar_taka/features/auth/presentation/bloc/auth_state.dart';
import 'package:amar_taka/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  final authRepository = sl<AuthRepository>();
  final token = await authRepository.getToken();
  runApp(MyApp(initialRoute: token != null ? '/home' : '/'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>(),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            AppRouter.createRouter(initialRoute).go('/signin');
          }
        },
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme,
          routerConfig: AppRouter.createRouter(initialRoute),
        ),
      ),
    );
  }
}


