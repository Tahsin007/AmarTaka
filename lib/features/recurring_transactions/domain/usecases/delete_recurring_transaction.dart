
import 'package:amar_taka/features/recurring_transactions/domain/repositories/recurring_transaction_repository.dart';
import 'package:amar_taka/core/error/failure.dart';
import 'package:amar_taka/core/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';

class DeleteRecurringTransaction implements UseCase<void, int> {
  final RecurringTransactionRepository repository;

  DeleteRecurringTransaction(this.repository);

  @override
  Future<Either<Failure, void>> call(int id) async {
    return await repository.deleteRecurringTransaction(id);
  }
}
