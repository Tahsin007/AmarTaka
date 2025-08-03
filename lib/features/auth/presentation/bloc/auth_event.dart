import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String userName;
  final String password;

  const LoginEvent({required this.userName, required this.password});

  @override
  List<Object> get props => [userName, password];
}

class SignupEvent extends AuthEvent {
  final String userName;
  final String email;
  final String password;

  const SignupEvent({
    required this.userName,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [userName, email, password];
}

class LogoutEvent extends AuthEvent {}
