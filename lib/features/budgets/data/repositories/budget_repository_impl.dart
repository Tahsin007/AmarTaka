
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
}
