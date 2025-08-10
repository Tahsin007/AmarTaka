import 'package:amar_taka/core/common/app_loader.dart';
import 'package:amar_taka/core/common/app_primary_button.dart';
import 'package:amar_taka/core/theme/app_pallete.dart';
import 'package:amar_taka/core/theme/app_text_styles.dart';
import 'package:amar_taka/features/budgets/domain/budget_entity.dart';
import 'package:amar_taka/features/budgets/presentation/bloc/budget_bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

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

  void _showEditBudgetDialog(BuildContext context, BudgetEntity budget) {
    final TextEditingController amountController = TextEditingController(
      text: budget.amount.toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Monthly Budget'),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter new amount',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPallete.primaryColor, // background color
                foregroundColor: Colors.white, // text color
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ), // padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // rounded corners
                ),
              ),
              onPressed: () {
                final amount = double.tryParse(amountController.text);
                if (amount != null) {
                  context.read<BudgetBloc>().add(
                    UpdateMonthlyBudgetEvent(
                      id: budget.id ?? 0,
                      month: DateTime.now().month,
                      year: DateTime.now().year,
                      amount: amount,
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budgets')),
      body: BlocBuilder<BudgetBloc, BudgetState>(
        builder: (context, state) {
          if (state is BudgetLoading) {
            return const Center(child: AppLoader());
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animation/budget-animation.json',
            width: 200,
            height: 200,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 20),
          Text('Track Your Monthly Budget', style: AppTextStyle.h2),
          const SizedBox(height: 20),
          Text("Take control of your finances by tracking a monthly goal."),
          SizedBox(height: 30),
          Card(
            elevation: 10,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Your monthly budget for ${_getMonthName(DateTime.now().month)}",
                    style: AppTextStyle.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "${budget.amount}",
                    style: AppTextStyle.h1.copyWith(
                      color: AppPallete.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  AppButton(
                    btnText: "Edit Monthly Budget",
                    onBtnPressed: () {
                      _showEditBudgetDialog(context, budget);
                      // final amount = double.tryParse(amountController.text);
                    },
                  ),
                ],
              ),
            ),
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
          Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: AppPallete.lightGray,
            ),
            child: Icon(
              Icons.file_open,
              color: AppPallete.primaryColor,
              size: 50,
            ),
          ),
          SizedBox(height: 20),
          Text('Set Your Monthly Budget', style: AppTextStyle.h2),
          const SizedBox(height: 20),
          Text("Take control of your finances by setting a monthly goal."),
          SizedBox(height: 30),
          Card(
            elevation: 10,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Montly Budget",
                    style: AppTextStyle.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '0.00',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  AppButton(
                    btnText: "Add Budget",
                    onBtnPressed: () {
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
                  ),
                ],
              ),
            ),
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
