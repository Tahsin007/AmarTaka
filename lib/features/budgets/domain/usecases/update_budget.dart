import 'package:amar_taka/features/budgets/domain/budget_entity.dart';
import 'package:amar_taka/features/budgets/domain/repositories/budget_repository.dart';

class UpdateBudget {
  final BudgetRepository repository;

  UpdateBudget(this.repository);

  Future<BudgetEntity> call(BudgetEntity updatedBudget) async {
    return await repository.updateMonthlyBudget(updatedBudget);
  }
}