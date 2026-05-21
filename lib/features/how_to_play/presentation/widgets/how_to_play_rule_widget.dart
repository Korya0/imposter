import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/painters/quiet_sketchy_painter.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class HowToPlayRuleWidget extends StatelessWidget {
  const HowToPlayRuleWidget({
    required this.rule,
    required this.stepNumber,
    super.key,
  });

  final String rule;
  final int stepNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.p(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: context.s(30),
            height: context.s(30),
            child: CustomPaint(
              painter: QuietSketchyPainter(
                color: AppColors.primary,
              ),
              child: Center(
                child: Text(
                  stepNumber.toString(),
                  style: AppTextStyles.font15W700Primary,
                ),
              ),
            ),
          ),
          const AppGap(12, isVertical: false),
          Expanded(
            child: AppTextWidget(
              rule,
              style: AppTextStyles.font20W400White,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
