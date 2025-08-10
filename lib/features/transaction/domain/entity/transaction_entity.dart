import 'dart:ffi';

class TransactionEntity{
  double amount;
  String description;
  String type;
  String date;
  int categoryId;

  TransactionEntity(this.amount,this.description,this.type,this.date,this.categoryId);
}