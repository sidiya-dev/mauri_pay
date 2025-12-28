import 'package:flutter/material.dart';
import 'package:mauri_pay/core/theme/app_colors.dart';

class AppTheme {
  static _border([Color color = AppColors.accentOrange]) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: color, width: 2),
  );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.backgroundColor),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: _border(),
      focusedBorder: _border(AppColors.lightOrange),
      errorBorder: _border(AppColors.errorColor),
      focusedErrorBorder: _border(AppColors.lightOrange),
      border: _border(),
      contentPadding: EdgeInsets.all(27),
    ),
  );
}
