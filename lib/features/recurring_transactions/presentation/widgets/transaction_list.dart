
import 'package:amar_taka/features/recurring_transactions/domain/entities/recurring_transaction.dart';
import 'package:amar_taka/features/recurring_transactions/presentation/widgets/transacetion_section.dart';
import 'package:amar_taka/features/recurring_transactions/presentation/widgets/transaction_card.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final List<RecurringTransaction> transactions;

  const TransactionsList({Key? key, required this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Overdue Section
            TransactionSection(
              title: 'Overdue',
              badgeCount: transactions.where((element) => !element.isActive && element.nextOccurrence.isBefore(DateTime.now())).length,
              badgeColor: Color(0xFFFED7D7),
              badgeTextColor: Color(0xFFC53030),
              transactions: transactions.where((element) => !element.isActive && element.nextOccurrence.isBefore(DateTime.now())).toList(),
            ),

            // Upcoming Section
            TransactionSection(
              title: 'Upcoming',
              badgeCount: transactions.where((element) => element.isActive && element.nextOccurrence.isAfter(DateTime.now())).length,
              badgeColor: Color(0xFFFEF5E7),
              badgeTextColor: Color(0xFFD69E2E),
              transactions: transactions.where((element) => element.isActive && element.nextOccurrence.isAfter(DateTime.now())).toList(),
            ),

            // Ongoing Section
            TransactionSection(
              title: 'Ongoing',
              badgeCount: transactions.where((element) => element.isActive && element.nextOccurrence.isBefore(DateTime.now())).length,
              badgeColor: Color(0xFFEDF2F7),
              badgeTextColor: Color(0xFF4A5568),
              transactions: transactions.where((element) => element.isActive && element.nextOccurrence.isBefore(DateTime.now())).toList(),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}