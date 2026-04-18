import 'dart:async';

import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_bottom_sheet/app_bottom_sheet.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_fonts.dart';
import 'package:imposter/core/theme/app_text_styles.dart';

void showHowToPlaySheet(BuildContext context) {
  unawaited(
    AppBottomSheet.show(
      context: context,
      title: AppStrings.howToPlay,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: AppStrings.howToPlaySteps.asMap().entries.map(
          (entry) {
            final index = entry.key;
            final step = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: AppTextWidget(
                      (index + 1).toString(),
                      style: AppTextStyles.font15W700Primary.copyWith(
                        color: AppColors.background,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Expanded(
                    child: AppTextWidget(
                      step,
                      style: AppTextStyles.font22W200Primary.copyWith(
                        fontWeight: LateefWeight.w600.weight,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            );
          },
        ).toList(),
      ),
    ),
  );
}
