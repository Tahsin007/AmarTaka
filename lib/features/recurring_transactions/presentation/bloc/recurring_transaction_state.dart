
part of 'recurring_transaction_bloc.dart';

abstract class RecurringTransactionState extends Equatable {
  const RecurringTransactionState();

  @override
  List<Object> get props => [];
}

class RecurringTransactionInitial extends RecurringTransactionState {}

class RecurringTransactionLoading extends RecurringTransactionState {}

class RecurringTransactionLoaded extends RecurringTransactionState {
  final List<RecurringTransaction> transactions;

  const RecurringTransactionLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class RecurringTransactionDetailsLoaded extends RecurringTransactionState {
  final RecurringTransaction transaction;

  const RecurringTransactionDetailsLoaded(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class RecurringTransactionSuccess extends RecurringTransactionState {}

class RecurringTransactionError extends RecurringTransactionState {
  final String message;

  const RecurringTransactionError(this.message);

  @override
  List<Object> get props => [message];
}

class RecurringSummaryLoaded extends RecurringTransactionState {
  final double income;
  final double expense;

  const RecurringSummaryLoaded(this.income,this.expense);

  @override
  List<Object> get props => [income,expense];
}