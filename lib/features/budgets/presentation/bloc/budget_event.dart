part of 'budget_bloc.dart';

abstract class BudgetEvent extends Equatable {
  const BudgetEvent();

  @override
  List<Object> get props => [];
}

class GetAllBudgetsEvent extends BudgetEvent {}

class AddBudgetEvent extends BudgetEvent {
  final int month;
  final int year;
  final double amount;

  const AddBudgetEvent({
    required this.month,
    required this.year,
    required this.amount,
  });

  @override
  List<Object> get props => [month, year, amount];
}
