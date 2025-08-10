import 'package:amar_taka/core/common/app_primary_button.dart';
import 'package:amar_taka/core/theme/app_pallete.dart';
import 'package:amar_taka/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/main-logo.png',
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              "Gain total control of your money",
              style: AppTextStyle.h1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            Text(
              "Become your own money manager and make every cent count",
              textAlign: TextAlign.center,
              style: AppTextStyle.bodyMedium.copyWith(
                color: AppPallete.darkGray,
              ),
            ),
            SizedBox(height: 30),
            AppButton(btnText: "Sign Up", onBtnPressed: () {context.push("/signup");}),
            SizedBox(height: 20),
            AppButton(btnText: "Login", onBtnPressed: () {context.push("/signin");}, isPrimary: false),
          ],
        ),
      ),
    );
  }
}
