

import 'package:amar_taka/core/error/exceptions.dart';
import 'package:amar_taka/core/error/failure.dart';
import 'package:amar_taka/core/network/network_info.dart';
import 'package:amar_taka/features/auth/data/datasources/remote_datasources.dart';
import 'package:amar_taka/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSources remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, String>> login(String userName, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await remoteDataSource.login(userName, password);
        return Right(token);
      } on ServerException {
        return Left(Failure("Server Exception"));
      }catch (e){
        return Left(Failure(e.toString()));
      }
    } else {
      return Left(Failure("Internet is not connected"));
    }
  }

  @override
  Future<Either<Failure, void>> signup(String userName, String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.signup(userName, email, password);
        return const Right(null);
      } on ServerException {
        return Left(Failure("Server Exception"));
      }catch (e){
        return Left(Failure(e.toString()));
      }
    } else {
      return Left(Failure("Internet is not connected"));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.logout();
        return const Right(null);
      } on ServerException {
        return Left(Failure("Server Exception"));
      }catch(e){
        return Left(Failure(e.toString()));

      }
    } else {
      return Left(Failure("Internet is not connected"));
    }
  }

  @override
  Future<String?> getToken() async {
    return await remoteDataSource.getToken();
  }

  @override
  Future<void> clearToken() async {
    await remoteDataSource.clearToken();
  }
}
