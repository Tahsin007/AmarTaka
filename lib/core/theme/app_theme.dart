import 'package:amar_taka/core/theme/app_pallete.dart';
import 'package:amar_taka/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData.light().copyWith(
    primaryColor: AppPallete.primaryColor,
    scaffoldBackgroundColor: AppPallete.white,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppPallete.primaryColor,
      primary: AppPallete.primaryColor,
      secondary: AppPallete.secondaryColor,
      surface: AppPallete.white,
      error: AppPallete.errorColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppPallete.white,
      foregroundColor: AppPallete.black,
      iconTheme: IconThemeData(color: AppPallete.black),
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppPallete.white,
      selectedItemColor: AppPallete.primaryColor,
      unselectedItemColor: Colors.grey,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppPallete.white,
      contentPadding: const EdgeInsets.all(20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(color: AppPallete.primaryColor, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(color: AppPallete.primaryColor, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(color: AppPallete.errorColor, width: 1.0),
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppPallete.backgroundColor,
      selectedColor: AppPallete.primaryColor,
      secondarySelectedColor: AppPallete.secondaryColor,
      labelStyle: TextStyle(color: AppPallete.black),
      secondaryLabelStyle: TextStyle(color: Colors.white70),
      padding: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    ),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.blueAccent,
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.black,
      contentPadding: const EdgeInsets.all(20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(color: Colors.red, width: 1.0),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      primary: Colors.blueAccent,
      secondary: Colors.blueAccent,
      surface: Colors.black,
      error: Colors.red,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
    ),

    //Central Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
    ),

    //Central Chip Theme
    chipTheme: ChipThemeData(
      // backgroundColor: AppPallete.backgroundColor,
      selectedColor: AppPallete.primaryColor,
      secondarySelectedColor: AppPallete.secondaryColor,
      labelStyle: AppTextStyle.labelMedium.copyWith(color: AppPallete.white),
      secondaryLabelStyle: TextStyle(color: Colors.white70),
      padding: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    ),
  );
}