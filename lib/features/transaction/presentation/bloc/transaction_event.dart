part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class AddTransactionEvent extends TransactionEvent {
  final TransactionEntity transactionData;

  const AddTransactionEvent(this.transactionData);

  @override
  List<Object> get props => [transactionData];
}

class GetTransactionEvent extends TransactionEvent {}
