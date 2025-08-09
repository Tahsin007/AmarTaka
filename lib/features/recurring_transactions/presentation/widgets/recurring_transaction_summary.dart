// Summary Cards Row Widget
import 'package:amar_taka/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class SummaryCardsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: SummaryCard(
              title: 'Total Recurring Income',
              amount: '\$5,200',
              subtitle: 'per month',
              icon: Icons.trending_up,
              color: AppPallete.primaryColor,
              backgroundColor: Color(0xFFC6F6D5),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: SummaryCard(
              title: 'Total Recurring Expenses',
              amount: '\$2,450',
              subtitle: 'per month',
              icon: Icons.trending_down,
              color: AppPallete.secondaryColor,
              backgroundColor: Color(0xFFFED7D7),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable Summary Card Widget
class SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color backgroundColor;

  const SummaryCard({
    Key? key,
    required this.title,
    required this.amount,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: color, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF718096),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, size: 14, color: color),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            amount,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2D3748),
            ),
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, color: Color(0xFFA0AEC0)),
          ),
        ],
      ),
    );
  }
}