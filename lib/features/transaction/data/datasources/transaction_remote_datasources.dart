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
      final url = Uri.parse("${AppConstants.apiBaseUrl}/transaction"); 
      print("Transaction amount : ${transactionData.amount}");
      print("Transaction amount : ${transactionData.description}");
      print("Transaction amount : ${transactionData.type}");
      print("Transaction amount : ${transactionData.date}");
      print("Transaction amount : ${transactionData.categoryId}");


      final response = await httpClient.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${await authRemoteDataSources.getToken()}'
          // Add any necessary headers, e.g., authentication
        },
        body: jsonEncode({
        "amount": transactionData.amount,
        "type": transactionData.type,
        "description": transactionData.description,
        "date": transactionData.date,
        "categoryId": transactionData.categoryId,
      }),
      );
      print("Transaction add response body :${response.body}");
      if (response.statusCode == 201) {
        print('Transaction added successfully');
        return;
      }else if(response.statusCode == 401){
        // await authRemoteDataSources.clearToken();
        throw Exception('Your Token Expired . Please Log Out');
      }else {
        print('Failed to add transaction: ${response.statusCode}');
        throw Exception('Failed to add transaction: ${response.body}');
      }
    }catch (e) {
      throw Exception('Failed to add transaction: ${e.toString()}');
    }
  }

  @override
  Future<List<TransactionModel>> getTransactions() async{
    try {
      final url = Uri.parse("${AppConstants.apiBaseUrl}/transaction");
      return httpClient.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': '${await authRemoteDataSources.getToken()}'
      }).then((response) {
        print(response.body);
        if (response.statusCode == 200) {
          final List<dynamic> data = jsonDecode(response.body);
          return data.map((item) => TransactionModel.fromJson(item)).toList();
        }
         else {
          print("From Get Transaction: ${response.body}");
          throw Exception('Failed to fetch transactions: ${response.body}');
        }
      });
    } catch (e) {
      print(e.toString());
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