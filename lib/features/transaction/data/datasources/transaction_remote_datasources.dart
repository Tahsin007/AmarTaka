import 'dart:convert';
import 'dart:io';
import 'package:amar_taka/core/constants/app_constants.dart';
import 'package:amar_taka/features/auth/data/datasources/remote_datasources.dart';
import 'package:http/http.dart' as http;

import 'package:amar_taka/features/transaction/data/model/transaction_model.dart';

abstract class TransactionRemoteDatasources {
  Future<void> addTransaction(TransactionModel transactionData);
  Future<List<TransactionModel>> getTransactions();
  Future<void> updateTransaction(String transactionId, TransactionModel updatedData);
  Future<void> deleteTransaction(String transactionId);
}

class TransactionRemoteDatasourcesImpl implements TransactionRemoteDatasources {
  final http.Client httpClient;
  final AuthRemoteDataSources authRemoteDataSources;
  TransactionRemoteDatasourcesImpl(this.httpClient, this.authRemoteDataSources);

  @override
  Future<void> addTransaction(TransactionModel transactionData)async {
    try{
      final url = Uri.parse("${AppConstants.apiBaseUrl}/transactions"); 
      final response = await httpClient.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${await authRemoteDataSources.getToken()}'
          // Add any necessary headers, e.g., authentication
        },
        body: transactionData.toJson(),
      );

      if (response.statusCode == 201) {
        print('Transaction added successfully');
      } else {
        print('Failed to add transaction: ${response.statusCode}');
        throw Exception('Failed to add transaction: ${response.body}');
      }
    }catch (e) {
      throw Exception('Failed to add transaction: $e');
    }
  }

  @override
  Future<List<TransactionModel>> getTransactions() async{
    try {
      final url = Uri.parse("${AppConstants.apiBaseUrl}/transactions");
      return httpClient.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': '${await authRemoteDataSources.getToken()}'
      }).then((response) {
        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          return data.map((item) => TransactionModel.fromJson(item)).toList();
        } else {
          throw Exception('Failed to fetch transactions: ${response.body}');
        }
      });
    } catch (e) {
      throw Exception('Failed to fetch transactions: $e');
    }
  }

  @override
  Future<void> updateTransaction(String transactionId, TransactionModel updatedData) {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTransaction(String transactionId) {
    // TODO: implement deleteTransaction
    throw UnimplementedError();
  }

}