import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF0A6CF0);
  static const accent = Color(0xFFFFA726);
  static const background = Color(0xFFF7F8FA);
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
    ).copyWith(secondary: AppColors.accent),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.black,
  );
}
