import 'package:amar_taka/core/common/app_primary_button.dart';
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

class AddIncomePage extends StatefulWidget {
  const AddIncomePage({super.key});

  @override
  State<AddIncomePage> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddIncomePage> {
  final _formKey = GlobalKey<FormState>();
  final _incomeTitleController = TextEditingController();
  final _amountController = TextEditingController();

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
      context.read<TransactionBloc>().add(
        AddTransactionEvent(
          TransactionEntity(
            double.tryParse(_amountController.text) ?? 0,
            _incomeTitleController.text,
            "INCOME",
            DateTime.now().toIso8601String().split('T').first,
            3,
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

  void _showAddCategoryDialog() {
    final categoryController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Category"),
          content: AppTextField(
            label: "Category Name",
            placeholder: "e.g. Salary",
            controller: categoryController,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (categoryController.text.isNotEmpty) {
                  context.read<CategoriesBloc>().add(
                    AddCategoryEvent(
                      name: categoryController.text,
                      type: "INCOME",
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Income"), centerTitle: true),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppCalendar(),
                SizedBox(height: 20),
                AppTextField(
                  label: "Income Title",
                  placeholder: "Remote Job",
                  controller: _incomeTitleController,
                  validator: (p0) => validateTitle(p0),
                ),
                SizedBox(height: 20),
                AppTextField(
                  label: "Amount",
                  placeholder: "Tk 2500",
                  controller: _amountController,
                  validator: (p0) => validateAmount(p0),
                ),
                SizedBox(height: 20),
                Text("Category", style: AppTextStyle.h3),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: BlocBuilder<CategoriesBloc, CategoriesState>(
                          builder: (context, state) {
                            if (state is CategoriesLoading) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (state is CategoriesLoaded) {
                              return Wrap(
                                spacing:
                                    8.0, // space between chips horizontally
                                runSpacing: 8.0, // space between lines
                                children: state.categories.map((category) {
                                  return Chip(
                                    label: Text(category.name),
                                    backgroundColor: AppPallete.primaryColor,
                                    labelStyle: AppTextStyle.bodySmall.copyWith(
                                      color: AppPallete.backgroundColor,
                                    ),
                                    labelPadding: EdgeInsets.all(8),
                                    deleteIcon: Icon(
                                      Icons.cancel,
                                      color: AppPallete.lightGray,
                                    ),
                                    onDeleted: () {
                                      context.read<CategoriesBloc>().add(
                                        DeleteCategoryEvent(
                                          id: category.id ?? 1,
                                        ),
                                      );

                                      context.read<CategoriesBloc>().add(
                                        GetAllCategoriesEvent()
                                      );
                                    },
                                  );
                                }).toList(),
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _showAddCategoryDialog,
                      icon: Icon(Icons.add, size: 40),
                    ),
                  ],
                ),
                SizedBox(height: 100),

                BlocListener<TransactionBloc, TransactionState>(
                  listener: (context, state) {
                    if (state is TransactionAdded) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Transaction added successfully!"),
                        ),
                      );
                      _incomeTitleController.clear();
                      _amountController.clear();
                      context.pop();
                      // Optionally navigate back
                      // context.pop();
                    } else if (state is TransactionError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<TransactionBloc, TransactionState>(
                    builder: (context, state) {
                      if (state is TransactionLoading) {
                        return Center(child: CircularProgressIndicator());
                      }

                      return AppButton(
                        btnText: "Add Income",
                        onBtnPressed: () => _handleBtnClick(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _incomeTitleController.dispose();
    _amountController.dispose();
    context.read<CategoriesBloc>().close();
    context.read<TransactionBloc>().close();
  }
}
