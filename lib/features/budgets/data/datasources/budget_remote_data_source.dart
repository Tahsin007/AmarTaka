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
    try{
          final token = await authRemoteDataSources.getToken();

    final response = await client.get(
      Uri.parse('${AppConstants.apiBaseUrl}/budget'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("GetAllBudget Response body :${response.body}");
    print("Get All Budget Response status : ${response.statusCode}");


    if (response.statusCode == 200) {
      final budgets = json.decode(response.body) as List;
      return budgets.map((budget) => BudgetModel.fromJson(budget)).toList();
    } else {
      throw ServerException(response.body);
    }
    }catch (e){
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<BudgetModel> addBudget(int month, int year, double amount) async {
    try{
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
    print("Budget Response body :${response.body}");
    if (response.statusCode == 201) {
      return BudgetModel.fromJson(json.decode(response.body));
    } else {
      print("Response status : ${response.statusCode}");
      throw ServerException(response.body);
    }
    }catch (e){
      print(e.toString());
      throw Exception(e.toString());
    }

  }
}

