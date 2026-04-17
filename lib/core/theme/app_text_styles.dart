import 'package:flutter/material.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_fonts.dart';

class AppTextStyles {
  static const TextStyle fontApp = AppFonts.lateefBase;
  static const TextStyle fontRuqaa = AppFonts.arefRuqaaBase;

  static TextStyle ruqaa60BoldPrimary = fontRuqaa.copyWith(
    color: AppColors.primary,
    fontSize: 60,
    fontWeight: RuqaaWeight.w700.weight,
  );
  static TextStyle ruqaa45BoldPrimary = fontRuqaa.copyWith(
    color: AppColors.primary,
    fontSize: 45,
    fontWeight: RuqaaWeight.w700.weight,
  );

  static TextStyle ruqaa24BoldPrimary = fontRuqaa.copyWith(
    color: AppColors.primary,
    fontSize: 24,
    fontWeight: RuqaaWeight.w700.weight,
  );

  static TextStyle ruqaa32W400Primary = fontRuqaa.copyWith(
    color: AppColors.primary,
    fontSize: 32,
    fontWeight: RuqaaWeight.w400.weight,
  );

  static TextStyle ruqaa48W400Primary = fontRuqaa.copyWith(
    color: AppColors.primary,
    fontSize: 48,
    fontWeight: RuqaaWeight.w400.weight,
  );

  static TextStyle ruqaa28W400White = fontRuqaa.copyWith(
    color: AppColors.white,
    fontSize: 28,
    fontWeight: RuqaaWeight.w400.weight,
  );

  static TextStyle ruqaa28W400Primary = fontRuqaa.copyWith(
    color: AppColors.primary,
    fontSize: 28,
    fontWeight: RuqaaWeight.w400.weight,
  );

  static TextStyle font22W800Primary = fontApp.copyWith(
    fontWeight: LateefWeight.w800.weight,
    color: AppColors.primary,
    fontSize: 18,
  );

  static TextStyle font45W800Secondary = fontApp.copyWith(
    fontSize: 45,
    fontWeight: LateefWeight.w800.weight,
    color: AppColors.secondary,
  );

  static TextStyle font30W800Background = fontApp.copyWith(
    fontSize: 30,
    fontWeight: LateefWeight.w800.weight,
    color: AppColors.background,
  );

  static TextStyle font24W800Primary = fontApp.copyWith(
    fontWeight: LateefWeight.w800.weight,
    color: AppColors.primary,
    fontSize: 24,
  );

  static TextStyle font36W800Primary = fontApp.copyWith(
    fontSize: 36,
    fontWeight: LateefWeight.w800.weight,
    color: AppColors.primary,
  );

  static TextStyle font40W800Primary = fontApp.copyWith(
    fontSize: 40,
    fontWeight: LateefWeight.w800.weight,
    color: AppColors.primary,
  );

  static TextStyle font45W800Background = fontApp.copyWith(
    fontSize: 45,
    fontWeight: LateefWeight.w800.weight,
    color: AppColors.background,
  );

  static TextStyle font22W200Primary = fontApp.copyWith(
    fontSize: 22,
    fontWeight: LateefWeight.w200.weight,
    color: AppColors.primary,
  );

  static TextStyle font22W200White = fontApp.copyWith(
    fontSize: 22,
    fontWeight: LateefWeight.w200.weight,
    color: AppColors.white.withValues(alpha: 0.8),
  );
}
