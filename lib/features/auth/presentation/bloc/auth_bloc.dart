import 'package:amar_taka/features/auth/domain/usecases/login.dart';
import 'package:amar_taka/features/auth/domain/usecases/logout.dart';
import 'package:amar_taka/features/auth/domain/usecases/signup.dart';
import 'package:amar_taka/features/auth/presentation/bloc/auth_event.dart';
import 'package:amar_taka/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Signup signup;
  final Logout logout;

  AuthBloc({required this.login, required this.signup, required this.logout}) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      final failureOrToken = await login(
        LoginParams(userName: event.userName, password: event.password),
      );
      failureOrToken.fold(
        (failure) => emit(const AuthError(message: 'Login Failed')),
        (token) => emit(AuthAuthenticated(token: token)),
      );
    });

    on<SignupEvent>((event, emit) async {
      emit(AuthLoading());
      final failureOrVoid = await signup(
        SignupParams(
          userName: event.userName,
          email: event.email,
          password: event.password,
        ),
      );
      failureOrVoid.fold(
        (failure) => emit(const AuthError(message: 'Signup Failed')),
        (_) => emit(AuthUnauthenticated()),
      );
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      final failureOrVoid = await logout(NoParams());
      failureOrVoid.fold(
        (failure) => emit(const AuthError(message: 'Logout Failed')),
        (_) => emit(AuthUnauthenticated()),
      );
    });
  }
}
