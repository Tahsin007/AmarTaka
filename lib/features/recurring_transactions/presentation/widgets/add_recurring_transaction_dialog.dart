import 'package:amar_taka/core/common/app_loader.dart';
import 'package:amar_taka/core/common/app_primary_button.dart';
import 'package:amar_taka/core/common/app_snackbar.dart';
import 'package:amar_taka/core/common/app_text_field.dart';
import 'package:amar_taka/core/theme/app_pallete.dart';
import 'package:amar_taka/core/theme/app_text_styles.dart';
import 'package:amar_taka/features/recurring_transactions/domain/entities/recurring_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amar_taka/features/recurring_transactions/presentation/bloc/recurring_transaction_bloc.dart';
import 'package:go_router/go_router.dart';

class AddRecurringTransactionDialog extends StatefulWidget {
  @override
  _AddRecurringTransactionDialogState createState() =>
      _AddRecurringTransactionDialogState();
}

class _AddRecurringTransactionDialogState
    extends State<AddRecurringTransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _maxOccurancesController =
      TextEditingController();
  String _selectedTransactionType = 'EXPENSE';
  String _selectedFrequency = 'MONTHLY';
  DateTime _selectedStartDate = DateTime.now();
  DateTime? _selectedEndDate;

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _maxOccurancesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? _selectedStartDate
          : (_selectedEndDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null &&
        picked != (isStartDate ? _selectedStartDate : _selectedEndDate)) {
      setState(() {
        if (isStartDate) {
          _selectedStartDate = picked;
        } else {
          _selectedEndDate = picked;
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newTransaction = RecurringTransaction(
        amount: double.parse(_amountController.text),
        description: _descriptionController.text,
        type: _selectedTransactionType,
        frequency: _selectedFrequency,
        startDate: _selectedStartDate,
        endDate: _selectedEndDate,
        nextOccurrence: _calculateNextOccurrence(
          _selectedStartDate,
          _selectedFrequency,
        ), 
        isActive: true,
        maxOccurances: int.parse(_maxOccurancesController.text),
      );
      context.read<RecurringTransactionBloc>().add(
        CreateRecurringTransactionEvent(newTransaction),
      );
      // Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Recurring Transaction'),
        centerTitle: true,
      ),
      body: BlocConsumer<RecurringTransactionBloc, RecurringTransactionState>(
        listener: (context, state) {
          if (state is RecurringTransactionError) {
            AppSnackBar.show(context, state.message, false);
          }
          if (state is RecurringTransactionSuccess) {
            AppSnackBar.show(
              context,
              "Add Recurring Transaction Success",
              true,
            );
          }
        },
        builder: (context, state) {
          if (state is RecurringTransactionLoading) {
            return Center(child: AppLoader());
          } else {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                        label: "Amount",
                        placeholder: "2000.0",
                        controller: _amountController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an amount';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      AppTextField(
                        label: "Description",
                        placeholder: "Netflix Subscription",
                        controller: _descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Transaction Type",
                        style: AppTextStyle.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _selectedTransactionType,
                        decoration: InputDecoration(
                          disabledBorder: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        items: <String>['INCOME', 'EXPENSE'].map((
                          String value,
                        ) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: AppTextStyle.bodyMedium),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedTransactionType = newValue!;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Frequency",
                        style: AppTextStyle.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _selectedFrequency,
                        decoration: InputDecoration(
                          disabledBorder: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        items: <String>['DAILY', 'WEEKLY', 'MONTHLY', 'YEARLY']
                            .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: AppTextStyle.bodyMedium,
                                ),
                              );
                            })
                            .toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedFrequency = newValue!;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      ListTile(
                        title: Text(
                          'Start Date: ${_selectedStartDate.toLocal().toString().split(' ')[0]}',
                        ),
                        trailing: Icon(
                          Icons.calendar_today,
                          color: AppPallete.primaryColor,
                        ),
                        onTap: () => _selectDate(context, true),
                      ),
                      SizedBox(height: 20),
                      ListTile(
                        title: Text(
                          'End Date: ${_selectedEndDate?.toLocal().toString().split(' ')[0] ?? 'Not set'}',
                        ),
                        trailing: Icon(
                          Icons.calendar_today,
                          color: AppPallete.primaryColor,
                        ),
                        onTap: () => _selectDate(context, false),
                      ),
                      SizedBox(height: 20),
                      AppTextField(
                        label: "Max Occurances",
                        placeholder:
                            "how many times you want to run it ? ex:12",
                        controller: _maxOccurancesController,
                      ),
                      SizedBox(height: 30),
                      AppButton(
                        btnText: "Add Transaction",
                        onBtnPressed: () {
                          _submitForm();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

DateTime _calculateNextOccurrence(DateTime startDate, String frequency) {
  switch (frequency) {
    case 'DAILY':
      return startDate.add(Duration(days: 1));
    case 'WEEKLY':
      return startDate.add(Duration(days: 7));
    case 'MONTHLY':
      return DateTime(startDate.year, startDate.month + 1, startDate.day);
    case 'YEARLY':
      return DateTime(startDate.year + 1, startDate.month, startDate.day);
    default:
      return startDate;
  }
}
