
import 'package:amar_taka/features/recurring_transactions/domain/entities/recurring_transaction.dart';
import 'package:amar_taka/features/recurring_transactions/domain/repositories/recurring_transaction_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:amar_taka/core/error/failure.dart';
import 'package:amar_taka/core/usecases/usecase.dart';

class UpdateRecurringTransaction implements UseCase<void, RecurringTransaction> {
  final RecurringTransactionRepository repository;

  UpdateRecurringTransaction(this.repository);

  @override
  Future<Either<Failure, void>> call(RecurringTransaction params) async {
    return await repository.updateRecurringTransaction(params);
  }
}
