import 'package:amar_taka/core/error/failure.dart';
import 'package:amar_taka/core/usecases/usecase.dart';
import 'package:amar_taka/features/transaction/domain/entity/transaction_entity.dart';
import 'package:amar_taka/features/transaction/domain/repository/transaction_repository.dart';
import 'package:fpdart/fpdart.dart';
class AddTransactionUseCase implements UseCase<void, TransactionEntity> {
  final TransactionRepository transactionRepository;

  AddTransactionUseCase(this.transactionRepository);

  @override
  Future<Either<Failure, void>> call(TransactionEntity transactionData) {
    return transactionRepository.addTransaction(transactionData);
  }
}

