
import 'package:amar_taka/features/budgets/domain/budget_entity.dart';

abstract class BudgetRepository {
  Future<List<BudgetEntity>> getAllBudgets();
  Future<BudgetEntity> addBudget(int month, int year, double amount);
  Future<BudgetEntity> updateMonthlyBudget(BudgetEntity updatedBudget);
}
