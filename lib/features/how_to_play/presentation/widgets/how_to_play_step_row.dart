import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/presentation/widgets/tactile_sketchy_icon_button.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/features/how_to_play/presentation/utils/rule_text_highlighter.dart';

class HowToPlayStepRow extends StatelessWidget {
  const HowToPlayStepRow({
    required this.index,
    required this.stepText,
    super.key,
  });

  final int index;
  final String stepText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.p(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: context.s(28),
            height: context.s(28),
            child: CustomPaint(
              painter: QuietSketchyPainter(
                color: AppColors.primary,
              ),
              child: Center(
                child: AppTextWidget(
                  (index + 1).toString(),
                  style: AppTextStyles.font15W700Primary.copyWith(
                    color: AppColors.primary,
                    fontSize: context.f(14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const AppGap(12, isVertical: false),
          Expanded(
            child: Text.rich(
              RuleTextHighlighter.getCachedSpan(context, stepText),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
