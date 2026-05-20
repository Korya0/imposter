import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/presentation/widgets/app_sketchy_card/sketchy_card_painter.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class FeedbackDiscardDialog extends StatelessWidget {
  const FeedbackDiscardDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 340),
        child: CustomPaint(
          painter: SketchyCardPainter(
            color: AppColors.primary,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.p(24),
              vertical: context.p(26),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppGap(16),
                Align(
                  child: AppTextWidget(
                    AppStrings.discardFeedbackTitle,
                    style: AppTextStyles.font24W700Primary,
                  ),
                ),
                const AppGap(16),
                AppTextWidget(
                  AppStrings.discardFeedbackMessage,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.font18W700Primary.copyWith(
                    color: AppColors.white.withValues(alpha: 0.9),
                    fontSize: 16,
                  ),
                ),
                const AppGap(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: AppButton(
                        height: context.h(48),
                        onTap: () => Navigator.pop(context, false),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: AppTextWidget(
                            AppStrings.continueWriting,
                            style: AppTextStyles.font18W700Primary.copyWith(
                              color: AppColors.secondary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const AppGap(12),
                    Expanded(
                      child: AppButton(
                        height: context.h(48),
                        onTap: () => Navigator.pop(context, true),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: AppTextWidget(
                            AppStrings.discardAndExit,
                            style: AppTextStyles.font18W700Primary.copyWith(
                              color: AppColors.secondary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
