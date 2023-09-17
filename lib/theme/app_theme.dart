import 'package:flutter/material.dart';
import 'package:kooha/utils/color.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: AppColors.primaryColor,
          primary: AppColors.white,
          onPrimary: AppColors.white,
          error: AppColors.errorColor,
          secondary: AppColors.secondaryColor),
      useMaterial3: true,
      elevatedButtonTheme: elevatedButtonTheme);

  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          100,
        ),
      ),
    ).copyWith(
        backgroundColor:
            MaterialStatePropertyAll<Color>(AppColors.primaryColor),
        fixedSize:
            MaterialStateProperty.all<Size>(const Size(double.maxFinite, 62))),
  );
}
