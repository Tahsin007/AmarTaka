import 'package:amar_taka/core/common/app_primary_button.dart';
import 'package:amar_taka/core/common/app_snackbar.dart';
import 'package:amar_taka/core/common/app_text_field.dart';
import 'package:amar_taka/core/theme/app_pallete.dart';
import 'package:amar_taka/core/theme/app_text_styles.dart';
import 'package:amar_taka/features/category/presentation/bloc/categories_bloc.dart';
import 'package:amar_taka/features/transaction/domain/entity/transaction_entity.dart';
import 'package:amar_taka/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:amar_taka/features/transaction/presentation/widgets/app_calender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddTransactionData extends StatefulWidget {
  const AddTransactionData({super.key});

  @override
  State<AddTransactionData> createState() => _AddTransactionDataState();
}

class _AddTransactionDataState extends State<AddTransactionData>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _incomeTitleController = TextEditingController();
  final _amountController = TextEditingController();
  int? _selectedCategoryId;
  int _selectedTabIndex = 0;

  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
    }
    return null;
  }

  String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }
    return null;
  }

  void _handleBtnClick() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCategoryId == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Please select a category")));
        return;
      }

      final transactionType = _selectedTabIndex == 0
          ? "INCOME"
          : "EXPENSE"; // 👈 Based on tab

      context.read<TransactionBloc>().add(
        AddTransactionEvent(
          TransactionEntity(
            double.tryParse(_amountController.text) ?? 0,
            _incomeTitleController.text,
            transactionType,
            DateTime.now().toIso8601String().split('T').first,
            _selectedCategoryId ?? 1,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<CategoriesBloc>().add(GetAllCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Transaction"),
          centerTitle: true,
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
            },
            tabs: [
              Tab(text: 'Income'),
              Tab(text: 'Expense'),
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCalendar(),
                  SizedBox(height: 20),
                  AppTextField(
                    label: "Transaction Title",
                    placeholder: "Remote Job",
                    controller: _incomeTitleController,
                    validator: validateTitle,
                  ),
                  SizedBox(height: 20),
                  AppTextField(
                    label: "Amount",
                    placeholder: "Tk 2500",
                    controller: _amountController,
                    validator: validateAmount,
                  ),
                  SizedBox(height: 20),
                  Text("Category", style: AppTextStyle.h3),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: BlocBuilder<CategoriesBloc, CategoriesState>(
                          builder: (context, state) {
                            if (state is CategoriesLoading) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (state is CategoriesLoaded) {
                              return Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children: state.categories.map((category) {
                                  return InputChip(
                                    label: Text(category.name),
                                    selected:
                                        _selectedCategoryId == category.id,
                                    selectedColor: AppPallete.secondaryColor,
                                    backgroundColor: AppPallete.primaryColor,
                                    labelStyle: AppTextStyle.bodySmall.copyWith(
                                      color: AppPallete.backgroundColor,
                                    ),
                                    onSelected: (isSelected) {
                                      setState(() {
                                        _selectedCategoryId = isSelected
                                            ? category.id
                                            : null;
                                      });
                                    },
                                  );
                                }).toList(),
                              );
                            }
                            if (state is CategoriesError) {
                              return ErrorWidget(state.message);
                            }
                            return Container();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 100),
                  BlocListener<TransactionBloc, TransactionState>(
                    listener: (context, state) {
                      if (state is TransactionAdded) {
                        appSnackBar(
                          context,
                          "Transaction Added Successfull",
                          true,
                        );
                        _incomeTitleController.clear();
                        _amountController.clear();
                        context.pop();
                      } else if (state is TransactionError) {
                        appSnackBar(context, state.message, false);
                      }
                    },
                    child: BlocBuilder<TransactionBloc, TransactionState>(
                      builder: (context, state) {
                        if (state is TransactionLoading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return AppButton(
                          btnText: _selectedTabIndex == 0
                              ? "Add Income"
                              : "Add Expense",
                          onBtnPressed: _handleBtnClick,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _incomeTitleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
