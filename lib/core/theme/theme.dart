import 'package:flutter/material.dart';
import 'package:online_exam/core/colors/colors.dart';

abstract class AppTheme {
  static ThemeData lightTheme = getTheme(
    ColorScheme.light(
      brightness: Brightness.light,
      primary: AppColors.blue,
      onPrimary: AppColors.white,
      secondary: AppColors.black,
      onSecondary: AppColors.white,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.blue,
    ),
  );

  static ThemeData getTheme(ColorScheme colorScheme) {
    return ThemeData(colorScheme: colorScheme);
  }
}
