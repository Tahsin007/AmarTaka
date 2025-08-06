import 'dart:convert';
import 'package:amar_taka/core/constants/app_constants.dart';
import 'package:amar_taka/core/error/exceptions.dart';
import 'package:amar_taka/features/auth/data/datasources/remote_datasources.dart';
import 'package:amar_taka/features/budgets/data/budget_model.dart';
import 'package:http/http.dart' as http;

abstract class BudgetRemoteDataSource {
  Future<List<BudgetModel>> getAllBudgets();
  Future<BudgetModel> addBudget(int month, int year, double amount);
}

class BudgetRemoteDataSourceImpl implements BudgetRemoteDataSource {
  final http.Client client;
  final AuthRemoteDataSources authRemoteDataSources;

  BudgetRemoteDataSourceImpl(
      {required this.client, required this.authRemoteDataSources});

  @override
  Future<List<BudgetModel>> getAllBudgets() async {
    final token = await authRemoteDataSources.getToken();

    final response = await client.get(
      Uri.parse('${AppConstants.apiBaseUrl}/budget'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final budgets = json.decode(response.body) as List;
      return budgets.map((budget) => BudgetModel.fromJson(budget)).toList();
    } else {
      throw ServerException(response.body);
    }
  }

  @override
  Future<BudgetModel> addBudget(int month, int year, double amount) async {
    final token = await authRemoteDataSources.getToken();
    final response = await client.post(
      Uri.parse('${AppConstants.apiBaseUrl}/budget'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'month': month,
        'year': year,
        'amount': amount,
      }),
    );

    if (response.statusCode == 201) {
      return BudgetModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(response.body);
    }
  }
}

