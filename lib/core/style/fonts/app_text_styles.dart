import 'package:flutter/material.dart';
import 'package:imposter/core/style/fonts/app_fonts.dart';
import 'package:imposter/core/style/theme/app_colors.dart';

class AppTextStyles {
  static const TextStyle font = TextStyle(
    fontFamily: AppFonts.appFont,
  );
  static TextStyle font60W700Primary = font.copyWith(
    color: AppColors.primary,
    fontSize: 60,
    fontWeight: FontWeightHelper.w700.weight,
  );

  static TextStyle font45W700Primary = font.copyWith(
    color: AppColors.primary,
    fontSize: 45,
    fontWeight: FontWeightHelper.w700.weight,
  );

  static TextStyle font45W700SecretWord = font.copyWith(
    color: AppColors.primary,
    fontSize: 45,
    fontWeight: FontWeightHelper.w700.weight,
    fontFamily: 'sans-serif',
  );

  static TextStyle font24W700Primary = font.copyWith(
    color: AppColors.primary,
    fontSize: 24,
    fontWeight: FontWeightHelper.w700.weight,
  );

  static TextStyle font32W400Primary = font.copyWith(
    color: AppColors.primary,
    fontSize: 32,
    fontWeight: FontWeightHelper.w400.weight,
  );

  static TextStyle font48W400Primary = font.copyWith(
    color: AppColors.primary,
    fontSize: 48,
    fontWeight: FontWeightHelper.w400.weight,
  );

  static TextStyle font28W400White = font.copyWith(
    color: AppColors.white.withValues(alpha: 0.8),
    fontSize: 28,
    fontWeight: FontWeightHelper.w400.weight,
  );

  static TextStyle font28W400Primary = font.copyWith(
    color: AppColors.primary,
    fontSize: 28,
    fontWeight: FontWeightHelper.w400.weight,
  );

  static TextStyle font24W700White = font.copyWith(
    color: AppColors.white,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );

  static TextStyle font18W700Primary = font.copyWith(
    fontWeight: FontWeightHelper.w700.weight,
    color: AppColors.primary,
    fontSize: 18,
  );

  static TextStyle font20W400White = font.copyWith(
    color: AppColors.white,
    fontWeight: FontWeightHelper.w400.weight,
    fontSize: 20,
  );

  static TextStyle font45W700Secondary = font.copyWith(
    fontSize: 45,
    fontWeight: FontWeightHelper.w700.weight,
    color: AppColors.secondary,
  );

  static TextStyle font32W700Secondary = font.copyWith(
    fontSize: 32,
    fontWeight: FontWeightHelper.w700.weight,
    color: AppColors.secondary,
  );

  static TextStyle font36W700Secondary = font.copyWith(
    fontSize: 36,
    fontWeight: FontWeightHelper.w700.weight,
    color: AppColors.secondary,
  );

  static TextStyle font30W700Background = font.copyWith(
    fontSize: 30,
    fontWeight: FontWeightHelper.w700.weight,
    color: AppColors.background,
  );
  static TextStyle font36W700Background = font.copyWith(
    fontSize: 36,
    fontWeight: FontWeightHelper.w700.weight,
    color: AppColors.background,
  );

  static TextStyle font36W700Primary = font.copyWith(
    fontSize: 36,
    fontWeight: FontWeightHelper.w700.weight,
    color: AppColors.primary,
  );

  static TextStyle font28W700Primary = font.copyWith(
    fontSize: 28,
    fontWeight: FontWeightHelper.w700.weight,
    color: AppColors.primary,
  );

  static TextStyle font34W700Primary = font.copyWith(
    fontSize: 34,
    fontWeight: FontWeightHelper.w700.weight,
    color: AppColors.primary,
  );

  static TextStyle font40W700Primary = font.copyWith(
    fontSize: 40,
    fontWeight: FontWeightHelper.w700.weight,
    color: AppColors.primary,
  );

  static TextStyle font45W700Background = font.copyWith(
    fontSize: 45,
    fontWeight: FontWeightHelper.w700.weight,
    color: AppColors.background,
  );

  static TextStyle font22W400Primary = font.copyWith(
    fontSize: 22,
    fontWeight: FontWeightHelper.w400.weight,
    color: AppColors.primary,
  );

  static TextStyle font22W400White = font.copyWith(
    fontSize: 22,
    fontWeight: FontWeightHelper.w400.weight,
    color: AppColors.white.withValues(alpha: 0.8),
  );

  static TextStyle font26W400White = font.copyWith(
    fontSize: 26,
    fontWeight: FontWeightHelper.w400.weight,
    color: AppColors.white.withValues(alpha: 0.8),
  );

  static TextStyle font24W400Secondary = font.copyWith(
    fontSize: 24,
    fontWeight: FontWeightHelper.w400.weight,
    color: AppColors.secondary,
  );

  static TextStyle font15W700Primary = font.copyWith(
    fontSize: 15,
    fontWeight: FontWeightHelper.w700.weight,
    color: AppColors.primary,
  );
}
