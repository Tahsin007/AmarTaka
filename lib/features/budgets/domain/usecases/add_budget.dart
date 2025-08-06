
import 'package:amar_taka/features/budgets/domain/budget_entity.dart';
import 'package:amar_taka/features/budgets/domain/repositories/budget_repository.dart';

class AddBudget {
  final BudgetRepository repository;

  AddBudget(this.repository);

  Future<BudgetEntity> call(int month, int year, double amount) async {
    return await repository.addBudget(month, year, amount);
  }
}
