import 'package:amar_taka/core/common/app_loader.dart';
import 'package:amar_taka/core/common/app_snackbar.dart';
import 'package:amar_taka/core/theme/app_pallete.dart';
import 'package:amar_taka/core/theme/app_text_styles.dart';
import 'package:amar_taka/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:amar_taka/features/auth/presentation/bloc/auth_event.dart';
import 'package:amar_taka/features/home/presentation/pages/summary_card.dart';
import 'package:amar_taka/features/home/presentation/pages/title_text.dart';
import 'package:amar_taka/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(GetTransactionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.backgroundColor,
        title: Text(widget.title, textAlign: TextAlign.center),
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutEvent());
              context.go('/signin');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SummaryCard(),
              SizedBox(height: 30),
              TitleText(firstText: "Transactions", secondText: "See All"),
              SizedBox(height: 16),
              BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  if(state is TransactionLoading){
                    return AppLoader();
                  }
                  if(state is TransactionError){
                    return ErrorWidget(state.message);
                    // appSnackBar(context, state.message, false);
                  }
                  if(state is TransactionLoaded){
                    return ListView.builder(
                    itemBuilder: (context, index) {
                      final transaction = state.transactions[index];
                      return ListTile(
                        title: Text(
                          transaction.description,
                          style: AppTextStyle.h3,
                        ),
                        subtitle: Text(
                          "Date : ${transaction.date}",
                          style: AppTextStyle.bodySmall,
                        ),
                        trailing: Text(
                          "-${transaction.amount} Tk",
                          style: AppTextStyle.bodyLarge,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: AppPallete.primaryColor,
                          child: Icon(
                            Icons.monetization_on,
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
