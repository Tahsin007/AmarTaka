import 'package:amar_taka/features/auth/domain/repositories/auth_repository.dart';
import 'package:amar_taka/core/error/failure.dart';
import 'package:amar_taka/core/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';

class Signup implements UseCase<void, SignupParams> {
  final AuthRepository repository;

  Signup(this.repository);

  @override
  Future<Either<Failure, void>> call(SignupParams params) async {
    return await repository.signup(params.userName, params.email, params.password);
  }
}

class SignupParams {
  final String userName;
  final String email;
  final String password;

  SignupParams({required this.userName, required this.email, required this.password});
}
