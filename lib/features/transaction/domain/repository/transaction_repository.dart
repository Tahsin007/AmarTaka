import 'package:amar_taka/core/error/failure.dart';
import 'package:amar_taka/features/transaction/domain/entity/transaction_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class TransactionRepository {
  Future<Either<Failure, void>> addTransaction(TransactionEntity transactionData);

  Future<Either<Failure, List<TransactionEntity>>> getTransactions();

  Future<Either<Failure, void>> updateTransaction(String transactionId, TransactionEntity updatedData);

  Future<Either<Failure, void>> deleteTransaction(String transactionId);

}