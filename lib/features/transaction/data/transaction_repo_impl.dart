import 'package:amar_taka/core/error/failure.dart';
import 'package:amar_taka/features/transaction/data/datasources/transaction_remote_datasources.dart';
import 'package:amar_taka/features/transaction/data/model/transaction_model.dart';
import 'package:amar_taka/features/transaction/domain/entity/transaction_entity.dart';
import 'package:amar_taka/features/transaction/domain/repository/transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

class TransactionRepoImpl implements TransactionRepository{
  final TransactionRemoteDatasources transactionRemoteDataSources;
  TransactionRepoImpl(this.transactionRemoteDataSources);
  @override
  Future<Either<Failure, void>> addTransaction(TransactionEntity transactionData) async {
    try{
      var transactionModel = TransactionModel.fromEntity(transactionData);
      await transactionRemoteDataSources.addTransaction(transactionModel);
      return Right(null);
    }catch (e) {
      return Left(Failure('Failed to add transaction: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTransaction(String transactionId) async{
    try{
      await transactionRemoteDataSources.deleteTransaction(transactionId);
      return Right(null);
    }catch (e) {
      return Left(Failure('Failed to delete transaction: $e'));
    }
  }

  @override
  Future<Either<Failure, List<TransactionEntity>>> getTransactions() async {
    try {
      final transactions = await transactionRemoteDataSources.getTransactions();
      return Right(transactions.map((e) => e as TransactionEntity).toList());
    } catch (e) {
      return Left(Failure('Failed to fetch transactions: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateTransaction(String transactionId, TransactionEntity updatedData) async {
    try {
      await transactionRemoteDataSources.updateTransaction(transactionId, updatedData as TransactionModel);
      return Right(null);
    } catch (e) {
      return Left(Failure('Failed to update transaction: $e'));
    }
  }

}