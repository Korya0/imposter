import 'package:flutter/material.dart';
import 'package:imposter/core/theme/app_colors.dart';

class AppTextStyles {
  static const String primaryFont = 'NotoNastaliqUrdu';

  static const TextStyle fontApp = TextStyle(fontFamily: primaryFont);

  static TextStyle font50BoldPrimary = fontApp.copyWith(
    color: AppColors.primary,
    fontSize: 50,
    fontWeight: FontWeight.w800,
  );
}
