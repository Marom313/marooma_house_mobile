import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF163D3E);
  static const accent = Color(0xFFE8B45F);
  static const background = Color(0xFFF4F5F2);
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ).copyWith(primary: AppColors.primary, secondary: AppColors.accent),
    useMaterial3: true,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: const Color(0xFF091C1E),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ).copyWith(primary: const Color(0xFF80B8B5), secondary: AppColors.accent),
    useMaterial3: true,
  );
}
