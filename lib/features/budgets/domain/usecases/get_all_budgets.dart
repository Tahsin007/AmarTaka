
import 'package:amar_taka/features/budgets/domain/budget_entity.dart';
import 'package:amar_taka/features/budgets/domain/repositories/budget_repository.dart';

class GetAllBudgets {
  final BudgetRepository repository;

  GetAllBudgets(this.repository);

  Future<List<BudgetEntity>> call() async {
    return await repository.getAllBudgets();
  }
}
