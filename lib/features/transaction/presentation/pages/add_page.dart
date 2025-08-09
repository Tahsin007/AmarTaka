import 'package:amar_taka/core/common/app_loader.dart';
import 'package:amar_taka/core/common/app_primary_button.dart';
import 'package:amar_taka/core/theme/app_pallete.dart';
import 'package:amar_taka/core/theme/app_text_styles.dart';
import 'package:amar_taka/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animation/transaction.json',
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
              AppButton(
                btnText: "Add Transaction",
                onBtnPressed: () {
                  context.push("/add-transaction");
                },
              ),

              SizedBox(height: 40),
              Text("Last Added", style: AppTextStyle.h2),
              SizedBox(height: 20),
              BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  if (state is TransactionLoading) {
                    return AppLoader();
                  } else if (state is TransactionError) {
                    return ErrorWidget(state.message);
                  } else if (state is TransactionLoaded) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final currentTransaction = state.transactions[index];
                        return ListTile(
                          title: Text(
                            currentTransaction.description,
                            style: AppTextStyle.h3,
                          ),
                          subtitle: Text(
                            "Date : ${currentTransaction.date}",
                            style: AppTextStyle.bodySmall,
                          ),
                          trailing: Text(
                            "${currentTransaction.amount} Tk",
                            style: AppTextStyle.bodyLarge,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: AppPallete.primaryColor,
                            child: Icon(
                              Icons.add_chart,
                              color: AppPallete.white,
                            ),
                          ),
                        );
                      },
                      itemCount: state.transactions.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
