import 'package:equatable/equatable.dart';

class Failure  {
  final String message;
  Failure({this.message = 'Something went wrong'});

}

class ServerFailure extends Failure {
  final String message;
  ServerFailure({required this.message});
}

class CacheFailure extends Failure {
  final String message;
  CacheFailure({required this.message});
}

class NetworkFailure extends Failure {
  final String message;
  NetworkFailure({required this.message});
}