import 'package:amar_taka/features/budgets/domain/budget_entity.dart';
import 'package:amar_taka/features/budgets/presentation/bloc/budget_bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetsPage extends StatefulWidget {
  const BudgetsPage({super.key});

  @override
  State<BudgetsPage> createState() => _BudgetsPageState();
}

class _BudgetsPageState extends State<BudgetsPage> {
  @override
  void initState() {
    super.initState();
    context.read<BudgetBloc>().add(GetAllBudgetsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budgets')),
      body: BlocBuilder<BudgetBloc, BudgetState>(
        builder: (context, state) {
          if (state is BudgetLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BudgetLoaded) {
            final currentMonth = DateTime.now().month;
            final currentYear = DateTime.now().year;
            BudgetEntity? foundBudget = state.budgets.firstWhereOrNull(
              (budget) =>
                  budget.month == currentMonth && budget.year == currentYear,
            );

            if (foundBudget != null) {
              return _buildBudgetView(foundBudget);
            } else {
              return _buildAddBudgetView();
            }
          } else if (state is BudgetError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No budgets found.'));
          }
        },
      ),
    );
  }

  Widget _buildBudgetView(dynamic budget) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.account_balance_wallet,
            size: 100,
            color: Colors.green,
          ),
          const SizedBox(height: 20),
          Text(
            'Budget for ${_getMonthName(DateTime.now().month)}: ${budget.amount}',
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildAddBudgetView() {
    final amountController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'No budget set for this month.',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter Budget Amount',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text);
              if (amount != null) {
                context.read<BudgetBloc>().add(
                  AddBudgetEvent(
                    month: DateTime.now().month,
                    year: DateTime.now().year,
                    amount: amount,
                  ),
                );
              }
            },
            child: const Text('Add Budget'),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return monthNames[month - 1];
  }
}
