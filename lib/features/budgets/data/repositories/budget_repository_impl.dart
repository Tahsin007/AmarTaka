import 'package:amar_taka/features/budgets/data/budget_model.dart';
import 'package:amar_taka/features/budgets/data/datasources/budget_remote_data_source.dart';
import 'package:amar_taka/features/budgets/domain/budget_entity.dart';
import 'package:amar_taka/features/budgets/domain/repositories/budget_repository.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final BudgetRemoteDataSource remoteDataSource;

  BudgetRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<BudgetEntity>> getAllBudgets() async {
    return await remoteDataSource.getAllBudgets();
  }

  @override
  Future<BudgetEntity> addBudget(int month, int year, double amount) async {
    return await remoteDataSource.addBudget(month, year, amount);
  }

  @override
  Future<BudgetEntity> updateMonthlyBudget(BudgetEntity updatedBudget) async {
    return await remoteDataSource.updateMonthlyBudget(
      BudgetModel(
        id: updatedBudget.id,
        month: updatedBudget.month,
        year: updatedBudget.year,
        amount: updatedBudget.amount,
      ),
    );
  }
}
