import 'package:amar_taka/features/auth/domain/repositories/auth_repository.dart';
import 'package:amar_taka/core/error/failure.dart';
import 'package:amar_taka/core/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';

class Login implements UseCase<String, LoginParams> {
  final AuthRepository repository;

  Login(this.repository);

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    return await repository.login(params.userName, params.password);
  }
}

class LoginParams {
  final String userName;
  final String password;

  LoginParams({required this.userName, required this.password});
}
