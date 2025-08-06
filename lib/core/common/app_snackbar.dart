import 'package:amar_taka/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

void appSnackBar(BuildContext context, String message,bool isSuccess) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isSuccess ? AppPallete.successColor:AppPallete.errorColor,
    ),
  );
}
