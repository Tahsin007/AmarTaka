import 'package:amar_taka/core/theme/app_pallete.dart';
import 'package:amar_taka/features/recurring_transactions/domain/entities/recurring_transaction.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final RecurringTransaction transaction;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TransactionCard({
    Key? key,
    required this.transaction,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: Color(0xFFF7FAFC)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Category Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blueAccent, // Placeholder for category color
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '💰', // Placeholder for category icon
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(width: 12),

              // Transaction Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.description,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: transaction.type == 'INCOME'
                            ? Color(0xFFC6F6D5)
                            : AppPallete.secondaryColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        transaction.type == 'INCOME'
                            ? 'Income'
                            : 'Expense',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: transaction.type == 'INCOME'
                              ? Color(0xFF276749)
                              : AppPallete.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Amount
              Text(
                '${transaction.type == 'INCOME' ? '+' : '-'}${transaction.amount}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: transaction.type == 'INCOME'
                      ? Color(0xFF38A169)
                      : Color(0xFFE53E3E),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${transaction.frequency} • ${transaction.nextOccurrence.toLocal().toString().split(' ')[0]}',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF718096),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: onEdit,
                    icon: Icon(Icons.edit, size: 16),
                    style: IconButton.styleFrom(
                      backgroundColor: Color(0xFFE2E8F0),
                      foregroundColor: Color(0xFF4A5568),
                      minimumSize: Size(28, 28),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    onPressed: onDelete,
                    icon: Icon(Icons.delete, size: 16),
                    style: IconButton.styleFrom(
                      backgroundColor: AppPallete.primaryColor,
                      foregroundColor: AppPallete.backgroundColor,
                      minimumSize: Size(28, 28),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

