import 'package:amar_taka/features/budgets/domain/budget_entity.dart';

class BudgetModel extends BudgetEntity {
  BudgetModel({
    required int month,
    required int year,
    required double amount,
    int? id
  }) : super(
          amount: amount,
          year: year,
          month: month,
          id: id
        );

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
      month: json['month'] as int,
      year: json['year'] as int,
      amount: (json['amount'] as num).toDouble(),
      id: json['id'] as int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'year': year,
      'amount': amount,
    };
  }
}

