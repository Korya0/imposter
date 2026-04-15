import 'package:flutter/material.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_fonts.dart';

abstract class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.background,
      ),
      fontFamily: AppFonts.lateefBase.fontFamily,
    );
  }
}
