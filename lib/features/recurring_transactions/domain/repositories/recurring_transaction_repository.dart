
import 'package:amar_taka/core/error/failure.dart';
import 'package:amar_taka/features/recurring_transactions/domain/entities/recurring_transaction.dart';
import 'package:fpdart/fpdart.dart';

abstract class RecurringTransactionRepository {
  Future<Either<Failure, void>> createRecurringTransaction(RecurringTransaction transaction);
  Future<Either<Failure, List<RecurringTransaction>>> getAllRecurringTransactions();
  Future<Either<Failure, RecurringTransaction>> getRecurringTransactionDetails(int id);
  Future<Either<Failure, void>> updateRecurringTransaction(RecurringTransaction transaction);
  Future<Either<Failure, void>> deleteRecurringTransaction(int id);
  Future<Either<Failure, List<RecurringTransaction>>> getUpcomingTransactions();
  Future<Either<Failure, List<RecurringTransaction>>> getOverdueTransactions();
}
