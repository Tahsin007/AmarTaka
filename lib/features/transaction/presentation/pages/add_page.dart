import 'package:amar_taka/core/common/app_primary_button.dart';
import 'package:amar_taka/core/theme/app_pallete.dart';
import 'package:amar_taka/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppButton(
                btnText: "Add Income",
                onBtnPressed: () {
                  context.push("/add-income");
                },
              ),

              SizedBox(height: 40),
              Text("Last Added", style: AppTextStyle.h2),
              SizedBox(height: 20),
              ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Transaction $index", style: AppTextStyle.h3),
                    subtitle: Text(
                      "Details of transaction $index",
                      style: AppTextStyle.bodySmall,
                    ),
                    trailing: Text(
                      "-${index * 100} Tk",
                      style: AppTextStyle.bodyLarge,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: AppPallete.primaryColor,
                      child: Icon(Icons.add_chart, color: AppPallete.white),
                    ),
                  );
                },
                itemCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
