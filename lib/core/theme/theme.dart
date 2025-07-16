import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return ThemeData(
      colorScheme: colorScheme,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          disabledBackgroundColor: AppColors.grey,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.r),
          ),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: colorScheme.secondary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: colorScheme.secondary,
        ),
        bodySmall: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
          color: colorScheme.secondary,
        ),
      ),
      appBarTheme: AppBarTheme(
        foregroundColor: colorScheme.secondary,
        centerTitle: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        labelStyle: TextStyle(color: AppColors.grey),
        fillColor: colorScheme.surface,
        border: outlineInputBorder(borderColor: AppColors.grey),
        enabledBorder: outlineInputBorder(borderColor: AppColors.grey),
        focusedBorder: outlineInputBorder(borderColor: AppColors.grey),
        errorBorder: outlineInputBorder(borderColor: AppColors.red),
        focusedErrorBorder: outlineInputBorder(borderColor: AppColors.red),
      ),
    );
  }

  static OutlineInputBorder outlineInputBorder({required Color borderColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: borderColor, width: 1.w),
    );
  }
}
