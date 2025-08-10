import 'dart:convert';
import 'package:amar_taka/core/constants/app_constants.dart';
import 'package:amar_taka/features/auth/data/datasources/remote_datasources.dart';
import 'package:amar_taka/features/recurring_transactions/data/models/recurring_transaction_model.dart';
import 'package:http/http.dart' as http;
import 'package:amar_taka/core/error/exception.dart';

import 'recurring_transaction_remote_data_source.dart';

class RecurringTransactionRemoteDataSourceImpl
    implements RecurringTransactionRemoteDataSource {
  final http.Client client;
  final AuthRemoteDataSources auth;
  RecurringTransactionRemoteDataSourceImpl({
    required this.client,
    required this.auth,
  });

  @override
  Future<void> createRecurringTransaction(
    RecurringTransactionModel transaction,
  ) async {
    try {
      final response = await client.post(
        Uri.parse('${AppConstants.apiBaseUrl}/recurring-transactions'),
        headers: {'Content-Type': 'application/json',
        'Authorization': '${await auth.getToken()}'},
        body: json.encode(transaction.toJson()),
      );
      print("Request Body : ${json.encode(transaction.toJson())}");
      print("Response Status Code : ${response.statusCode}");
      print("Response body: ${response.body}");
      
      if (response.statusCode != 201) {
        throw ServerException();
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<RecurringTransactionModel>> getAllRecurringTransactions() async {
    final response = await client.get(
      Uri.parse('${AppConstants.apiBaseUrl}/recurring-transactions'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList
          .map((json) => RecurringTransactionModel.fromJson(json))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RecurringTransactionModel> getRecurringTransactionDetails(
    int id,
  ) async {
    final response = await client.get(
      Uri.parse('${AppConstants.apiBaseUrl}/recurring-transactions/$id'),
    );

    if (response.statusCode == 200) {
      return RecurringTransactionModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> updateRecurringTransaction(
    RecurringTransactionModel transaction,
  ) async {
    final response = await client.put(
      Uri.parse(
        '${AppConstants.apiBaseUrl}/recurring-transactions/${transaction.id}',
      ),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(transaction.toJson()),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteRecurringTransaction(int id) async {
    final response = await client.delete(
      Uri.parse('${AppConstants.apiBaseUrl}/recurring-transactions/$id'),
    );

    if (response.statusCode != 204) {
      throw ServerException();
    }
  }

  @override
  Future<List<RecurringTransactionModel>> getUpcomingTransactions() async {
    final response = await client.get(
      Uri.parse('${AppConstants.apiBaseUrl}/recurring-transactions/upcoming'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList
          .map((json) => RecurringTransactionModel.fromJson(json))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<RecurringTransactionModel>> getOverdueTransactions() async {
    final response = await client.get(
      Uri.parse('${AppConstants.apiBaseUrl}/recurring-transactions/overdue'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList
          .map((json) => RecurringTransactionModel.fromJson(json))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
