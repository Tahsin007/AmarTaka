import 'package:amar_taka/core/error/exception.dart';
import 'package:amar_taka/core/error/failure.dart';
import 'package:amar_taka/core/network/network_info.dart';
import 'package:amar_taka/features/recurring_transactions/data/datasources/recurring_transaction_remote_data_source.dart';
import 'package:amar_taka/features/recurring_transactions/data/models/recurring_transaction_model.dart';
import 'package:amar_taka/features/recurring_transactions/domain/entities/recurring_transaction.dart';
import 'package:amar_taka/features/recurring_transactions/domain/repositories/recurring_transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

class RecurringTransactionRepositoryImpl
    implements RecurringTransactionRepository {
  final RecurringTransactionRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RecurringTransactionRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> createRecurringTransaction(
    RecurringTransaction transaction,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.createRecurringTransaction(
          RecurringTransactionModel(
            amount: transaction.amount,
            type: transaction.type,
            description: transaction.description,
            frequency: transaction.frequency,
            startDate: transaction.startDate,
            nextOccurrence: transaction.nextOccurrence,
            isActive: transaction.isActive,
            maxOccurances: transaction.maxOccurances,
          ),
        );
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure(message: "Server Error"));
      }
    } else {
      return Left(NetworkFailure(message: "Please Connect Your Internet"));
    }
  }

  @override
  Future<Either<Failure, List<RecurringTransaction>>>
  getAllRecurringTransactions() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTransactions = await remoteDataSource
            .getAllRecurringTransactions();
        return Right(remoteTransactions);
      } on ServerException {
        return Left(ServerFailure(message: "Server Error"));
      }
    } else {
      return Left(NetworkFailure(message: "Please Connect Your Internet"));
    }
  }

  @override
  Future<Either<Failure, RecurringTransaction>> getRecurringTransactionDetails(
    int id,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTransaction = await remoteDataSource
            .getRecurringTransactionDetails(id);
        return Right(remoteTransaction);
      } on ServerException {
        return Left(ServerFailure(message: "Server Error"));
      }
    } else {
      return Left(NetworkFailure(message: "Please Connect Your Internet"));
    }
  }

  @override
  Future<Either<Failure, void>> updateRecurringTransaction(
    RecurringTransaction transaction,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateRecurringTransaction(
          transaction as dynamic,
        );
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure(message: "Server Error"));
      }
    } else {
      return Left(NetworkFailure(message: "Please Connect Your Internet"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteRecurringTransaction(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteRecurringTransaction(id);
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure(message: "Server Error"));
      }
    } else {
      return Left(NetworkFailure(message: "Please Connect Your Internet"));
    }
  }

  @override
  Future<Either<Failure, List<RecurringTransaction>>>
  getUpcomingTransactions() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTransactions = await remoteDataSource
            .getUpcomingTransactions();
        return Right(remoteTransactions);
      } on ServerException {
        return Left(ServerFailure(message: "Server Error"));
      }
    } else {
      return Left(NetworkFailure(message: "Please Connect Your Internet"));
    }
  }

  @override
  Future<Either<Failure, List<RecurringTransaction>>>
  getOverdueTransactions() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTransactions = await remoteDataSource
            .getOverdueTransactions();
        return Right(remoteTransactions);
      } on ServerException {
        return Left(ServerFailure(message: "Server Error"));
      }
    } else {
      return Left(NetworkFailure(message: "Please Connect Your Internet"));
    }
  }
}
