import 'package:amar_taka/features/budgets/domain/budget_entity.dart';
import 'package:amar_taka/features/budgets/domain/usecases/add_budget.dart';
import 'package:amar_taka/features/budgets/domain/usecases/get_all_budgets.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final GetAllBudgets getAllBudgets;
  final AddBudget addBudget;

  BudgetBloc({
    required this.getAllBudgets,
    required this.addBudget,
  }) : super(BudgetInitial()) {
    on<GetAllBudgetsEvent>((event, emit) async {
      emit(BudgetLoading());
      try {
        final budgets = await getAllBudgets();
        emit(BudgetLoaded(budgets: budgets));
      } catch (e) {
        emit(BudgetError(message: e.toString()));
      }
    });

    on<AddBudgetEvent>((event, emit) async {
      emit(BudgetLoading());
      print("Budget request body: ${event.month} month, ${event.amount} amount, ${event.year} year");
      try {
        await addBudget(event.month, event.year, event.amount);
        emit(BudgetAdded());
      } catch (e) {
        emit(BudgetError(message: e.toString()));
      }
    });
  }
}
