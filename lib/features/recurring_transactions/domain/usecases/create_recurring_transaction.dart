
import 'package:amar_taka/features/recurring_transactions/domain/entities/recurring_transaction.dart';
import 'package:amar_taka/features/recurring_transactions/domain/repositories/recurring_transaction_repository.dart';
import 'package:amar_taka/core/error/failure.dart';
import 'package:amar_taka/core/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';

class CreateRecurringTransaction implements UseCase<void, RecurringTransaction> {
  final RecurringTransactionRepository repository;

  CreateRecurringTransaction(this.repository);

  @override
  Future<Either<Failure, void>> call(RecurringTransaction params) async {
    return await repository.createRecurringTransaction(params);
  }
}
