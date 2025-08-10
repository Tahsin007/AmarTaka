part of 'recurring_transaction_bloc.dart';

abstract class RecurringTransactionEvent extends Equatable {
  const RecurringTransactionEvent();

  @override
  List<Object> get props => [];
}

class CreateRecurringTransactionEvent extends RecurringTransactionEvent {
  final RecurringTransaction transaction;

  const CreateRecurringTransactionEvent(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class GetAllRecurringTransactionsEvent extends RecurringTransactionEvent {}

class GetRecurringTransactionByIdEvent extends RecurringTransactionEvent {
  final int id;

  const GetRecurringTransactionByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateRecurringTransactionEvent extends RecurringTransactionEvent {
  final RecurringTransaction transaction;

  const UpdateRecurringTransactionEvent(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class DeleteRecurringTransactionEvent extends RecurringTransactionEvent {
  final int id;

  const DeleteRecurringTransactionEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetUpcomingTransactionsEvent extends RecurringTransactionEvent {}

class GetOverdueTransactionsEvent extends RecurringTransactionEvent {}

class GetRecurringSummaryEvent extends RecurringTransactionEvent{
  final int month;
  final int year;

  GetRecurringSummaryEvent(this.month,this.year);

  
  @override
  List<Object> get props => [month,year];
}
