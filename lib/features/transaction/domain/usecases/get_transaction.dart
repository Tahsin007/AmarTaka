import 'package:amar_taka/core/error/failure.dart';
import 'package:amar_taka/core/usecases/usecase.dart';
import 'package:amar_taka/features/auth/domain/usecases/logout.dart';
import 'package:amar_taka/features/transaction/domain/entity/transaction_entity.dart';
import 'package:amar_taka/features/transaction/domain/repository/transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetTransactionUseCase implements UseCase<List<TransactionEntity>, NoParams> {
  final TransactionRepository transactionRepository;

  GetTransactionUseCase(this.transactionRepository);

  @override
  Future<Either<Failure, List<TransactionEntity>>> call(NoParams params) {
    return transactionRepository.getTransactions();
  }
}