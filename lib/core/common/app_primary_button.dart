import 'package:amar_taka/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:amar_taka/core/theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onBtnPressed;
  final bool isPrimary;

  const AppButton({
    super.key,
    required this.btnText,
    required this.onBtnPressed,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onBtnPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppPallete.primaryColor : AppPallete.lightGray,
          foregroundColor: isPrimary ? Colors.white : AppPallete.primaryColor,
          textStyle: AppTextStyle.buttonMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(btnText),
      ),
    );
  }
}
