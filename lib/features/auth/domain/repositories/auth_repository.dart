
import 'package:amar_taka/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> login(String userName, String password);
  Future<Either<Failure, void>> signup(String userName, String email, String password);
  Future<Either<Failure, void>> logout();
  Future<String?> getToken();
  Future<void> clearToken();
}
