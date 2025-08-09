import 'package:amar_taka/core/theme/app_pallete.dart';
import 'package:amar_taka/features/recurring_transactions/presentation/bloc/recurring_transaction_bloc.dart';
import 'package:amar_taka/features/recurring_transactions/presentation/widgets/recurring_transaction_summary.dart';
import 'package:amar_taka/features/recurring_transactions/presentation/widgets/transaction_list.dart';
import 'package:amar_taka/features/recurring_transactions/presentation/widgets/add_recurring_transaction_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Main Page
class RecurringTransactionsPage extends StatefulWidget {
  @override
  _RecurringTransactionsPageState createState() =>
      _RecurringTransactionsPageState();
}

class _RecurringTransactionsPageState extends State<RecurringTransactionsPage> {
  @override
  void initState() {
    super.initState();
    context.read<RecurringTransactionBloc>().add(GetAllRecurringTransactionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: BlocConsumer<RecurringTransactionBloc, RecurringTransactionState>(
          listener: (context, state) {
            if (state is RecurringTransactionError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is RecurringTransactionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Operation successful!')),
              );
              context.read<RecurringTransactionBloc>().add(GetAllRecurringTransactionsEvent());
            }
          },
          builder: (context, state) {
            if (state is RecurringTransactionLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RecurringTransactionLoaded) {
              return Column(
                children: [
                  // Header Section
                  CustomHeader(
                    title: 'Recurring Transactions',
                    onAddPressed: () => context.push('/add-recurring'),
                  ),
                  // Summary Cards Section
                  SummaryCardsRow(),
                  // Transactions List Section
                  Expanded(child: TransactionsList(transactions: state.transactions)),
                ],
              );
            } 
            return Column(
              children: [
                // Header Section
                CustomHeader(
                  title: 'Recurring Transactions',
                  onAddPressed: () => context.push('/add-recurring'),
                ),
                // Summary Cards Section
                SummaryCardsRow(),
                // Transactions List Section
                Expanded(child: TransactionsList(transactions: [])),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AddRecurringTransactionDialog(),
    );
  }
}

// Custom Header Widget
class CustomHeader extends StatelessWidget {
  final String title;
  final VoidCallback onAddPressed;

  const CustomHeader({
    Key? key,
    required this.title,
    required this.onAddPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3748),
            ),
          ),
          ElevatedButton(
            onPressed: onAddPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppPallete.primaryColor,
              foregroundColor: AppPallete.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 4,
              shadowColor: Color(0xFF7D31FA).withOpacity(0.3),
            ),
            child: Text(
              '+ Add',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
