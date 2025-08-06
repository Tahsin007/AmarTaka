import 'dart:ffi';

import 'package:amar_taka/features/transaction/domain/entity/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    required double amount,
    required String description,
    required String type,
    required String date,
    required int categoryId,
  }) : super(amount,description,type,date,categoryId);

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      amount: json['amount'] as double,
      description: json['description'] as String,
      type: json['type'] as String,
      date: json['date'] as String,
      categoryId: json['categoryId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'description': description,
      'type': type,
      'date': date,
      'categoryId': categoryId.toInt(),
    };
  }
  factory TransactionModel.fromEntity(TransactionEntity entity){
    return TransactionModel(amount: entity.amount, description: entity.description, type: entity.type, date: entity.date, categoryId: entity.categoryId);
  }

}
