
import 'package:amar_taka/features/recurring_transactions/domain/entities/recurring_transaction.dart';
import 'package:amar_taka/features/recurring_transactions/domain/repositories/recurring_transaction_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:amar_taka/core/error/failure.dart';
import 'package:amar_taka/core/usecases/usecase.dart';

class GetOverdueTransactions implements UseCase<List<RecurringTransaction>, NoParams> {
  final RecurringTransactionRepository repository;

  GetOverdueTransactions(this.repository);

  @override
  Future<Either<Failure, List<RecurringTransaction>>> call(NoParams params) async {
    return await repository.getOverdueTransactions();
  }
}
