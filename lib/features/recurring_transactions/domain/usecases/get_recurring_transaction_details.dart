
import 'package:amar_taka/features/recurring_transactions/domain/entities/recurring_transaction.dart';
import 'package:amar_taka/features/recurring_transactions/domain/repositories/recurring_transaction_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:amar_taka/core/error/failure.dart';
import 'package:amar_taka/core/usecases/usecase.dart';

class GetRecurringTransactionDetails implements UseCase<RecurringTransaction, int> {
  final RecurringTransactionRepository repository;

  GetRecurringTransactionDetails(this.repository);

  @override
  Future<Either<Failure, RecurringTransaction>> call(int id) async {
    return await repository.getRecurringTransactionDetails(id);
  }
}
