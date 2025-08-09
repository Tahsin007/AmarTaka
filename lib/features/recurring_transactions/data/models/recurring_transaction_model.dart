
import 'package:amar_taka/features/recurring_transactions/domain/entities/recurring_transaction.dart';

class RecurringTransactionModel extends RecurringTransaction {
  RecurringTransactionModel({
    super.id,
    required super.amount,
    required super.type,
    required super.description,
    required super.frequency,
    required super.startDate,
    super.endDate,
    required super.nextOccurrence,
    super.userId,
    super.categoryId,
    required super.isActive,
    super.maxOccurances
  });

  factory RecurringTransactionModel.fromJson(Map<String, dynamic> json) {
    return RecurringTransactionModel(
      id: json['id'],
      amount: (json['amount'] as num).toDouble(),
      type: json['type'],
      description: json['description'],
      frequency: json['frequency'],
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      nextOccurrence: DateTime.parse(json['nextOccurrence']),
      isActive: json['isActive'] as bool,
      maxOccurances: json['maxOccurrences'] !=null ? json['maxOccurrences'] as int :null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'type': type,
      'description': description,
      'frequency': frequency,
      'startDate': startDate.toIso8601String().split('T').first,
      'endDate': endDate?.toIso8601String().split('T').first,
      'nextOccurrence': nextOccurrence.toIso8601String().split('T').first,
      'isActive':isActive,
      'maxOccurances':maxOccurances ?? 12 ,
    };
  }
}
