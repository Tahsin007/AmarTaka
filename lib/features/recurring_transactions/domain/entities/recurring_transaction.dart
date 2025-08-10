
class RecurringTransaction {
  final int? id;
  final double amount;
  final String type; // e.g. "INCOME" or "EXPENSE"
  final String description;
  final String frequency; // e.g. "DAILY", "WEEKLY", "MONTHLY"
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime nextOccurrence;
  final int? userId;
  final int? categoryId;
  final bool isActive;
  final int? maxOccurances;

  RecurringTransaction({
    this.id,
    required this.amount,
    required this.type,
    required this.description,
    required this.frequency,
    required this.startDate,
    this.endDate,
    required this.nextOccurrence,
    this.userId,
    this.categoryId,
    required this.isActive,
    this.maxOccurances
  });
}
