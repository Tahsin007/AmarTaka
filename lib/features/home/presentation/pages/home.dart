import 'package:amar_taka/core/theme/app_pallete.dart';
import 'package:amar_taka/core/theme/app_text_styles.dart';
import 'package:amar_taka/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:amar_taka/features/auth/presentation/bloc/auth_event.dart';
import 'package:amar_taka/features/home/presentation/pages/summary_card.dart';
import 'package:amar_taka/features/home/presentation/pages/title_text.dart';
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
                      child: Icon(
                        Icons.monetization_on,
                        color: AppPallete.white,
                      ),
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
