import 'package:amar_taka/core/theme/app_pallete.dart';
import 'package:amar_taka/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  String firstText;
  String secondText;
  TitleText({super.key, required this.firstText,required this.secondText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(firstText,style: AppTextStyle.h2,),
          Text(secondText,style: AppTextStyle.bodyMedium.copyWith(color: AppPallete.darkGray),)
        ],
      ),
    );
  }
  }