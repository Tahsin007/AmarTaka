import 'package:amar_taka/features/budgets/domain/budget_entity.dart';
import 'package:amar_taka/features/budgets/domain/usecases/add_budget.dart';
import 'package:amar_taka/features/budgets/domain/usecases/get_all_budgets.dart';
import 'package:amar_taka/features/budgets/domain/usecases/update_budget.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final GetAllBudgets getAllBudgets;
  final AddBudget addBudget;
  final UpdateBudget updateBudget;

  BudgetBloc({
    required this.getAllBudgets,
    required this.addBudget,
    required this.updateBudget,
  }) : super(BudgetInitial()) {
    on<GetAllBudgetsEvent>((event, emit) async {
      emit(BudgetLoading());
      try {
        final budgets = await getAllBudgets();
        print("All The Budgets: ${budgets}");
        emit(BudgetLoaded(budgets: budgets));
      } catch (e) {
        emit(BudgetError(message: e.toString()));
      }
    });

    on<AddBudgetEvent>((event, emit) async {
      emit(BudgetLoading());
      print(
        "Budget request body: ${event.month} month, ${event.amount} amount, ${event.year} year",
      );
      try {
        await addBudget(event.month, event.year, event.amount);
        emit(BudgetAdded());
      } catch (e) {
        emit(BudgetError(message: e.toString()));
      }
    });

    on<UpdateMonthlyBudgetEvent>((event, emit) async {
      emit(BudgetLoading());
      print(
        "Budget request body: ID: ${event.id} ${event.month} month, ${event.amount} amount, ${event.year} year",
      );
      try {
        await updateBudget(
          BudgetEntity(
            id: event.id,
            month: event.month,
            year: event.year,
            amount: event.amount,
          ),
        );
        final budgets = await getAllBudgets();
        print("All The Budgets after budget update: ${budgets}");
        emit(BudgetLoaded(budgets: budgets));
      } catch (e) {
        emit(BudgetError(message: e.toString()));
      }
    });
  }
}
