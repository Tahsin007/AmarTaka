import 'package:amar_taka/features/auth/domain/usecases/logout.dart';
import 'package:amar_taka/features/transaction/domain/entity/transaction_entity.dart';
import 'package:amar_taka/features/transaction/domain/usecases/add_transaction.dart';
import 'package:amar_taka/features/transaction/domain/usecases/get_transaction.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactionUseCase getTransactionUseCase;
  final AddTransactionUseCase addTransactionUseCase;

  TransactionBloc(this.getTransactionUseCase, this.addTransactionUseCase)
    : super(TransactionInitial()) {
      on<AddTransactionEvent>(_onAddTransaction);
      on<GetTransactionEvent>(_onGetTransactions);

  }
  void _onAddTransaction(
    AddTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try{
    final result = await addTransactionUseCase(event.transactionData);
    result.fold(
      (failure) {
        emit(TransactionError(failure.message));
      },
      (_) {
        emit(TransactionAdded(event.transactionData));
      },
    );
    }catch (e){
      print("Error from the transaction bloc ${e.toString()}");
    }

  }

  void _onGetTransactions(GetTransactionEvent event,Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    final result = await getTransactionUseCase(NoParams());
    result.fold(
      (failure) => emit(TransactionError(failure.message)),
      (transactions) => emit(TransactionLoaded(transactions)),
    );
  }
}
