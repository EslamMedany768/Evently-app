import 'package:evantly_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData light =
      ThemeData(scaffoldBackgroundColor: Colors.white,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: AppColors.blue));

  static final ThemeData dark = ThemeData(
    appBarTheme: AppBarTheme(color: AppColors.primary_dark),
    scaffoldBackgroundColor: AppColors.primary_dark,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: AppColors.primary_dark)
  );
}
