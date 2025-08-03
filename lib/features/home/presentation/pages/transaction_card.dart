import 'package:amar_taka/core/constants/app_constants.dart';
import 'package:amar_taka/core/theme/app_pallete.dart';
import 'package:amar_taka/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatefulWidget {
  const TransactionCard({super.key});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: CircleAvatar(
              child: Image.asset("assets/images/main-logo.png"),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                Text("Money Transfer", style: AppTextStyle.h3),
                SizedBox(height: 10),
                Text(
                  "12:35 PM",
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppPallete.darkGray,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "-420 Tk",
            style: AppTextStyle.bodyLarge.copyWith(
              color: AppPallete.errorColor,
            ),
          ),
        ],
      ),
    );
  }
}
