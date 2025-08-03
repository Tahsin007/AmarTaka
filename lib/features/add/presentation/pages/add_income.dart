import 'package:amar_taka/core/common/app_primary_button.dart';
import 'package:amar_taka/core/common/app_text_field.dart';
import 'package:amar_taka/core/theme/app_text_styles.dart';
import 'package:amar_taka/features/add/presentation/widgets/app_calender.dart';
import 'package:flutter/material.dart';

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
      // context.read<AuthBloc>().add(
      //   LoginEvent(
      //     userName: _userNameController.text,
      //     password: _passwordController.text,
      //   ),
      // );
    }
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
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 2,
                          clipBehavior: Clip.none,
                          
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Chip(
                                label: Text("Chip $index"),
                                labelPadding: EdgeInsets.all(8),
                              ),
                            );
                          },

                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add, size: 40),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                AppButton(
                  btnText: "Add Income",
                  onBtnPressed: () => _handleBtnClick(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
