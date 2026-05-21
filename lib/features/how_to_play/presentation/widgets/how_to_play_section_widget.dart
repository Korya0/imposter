import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/presentation/painters/sketchy_horizontal_line_painter.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/how_to_play/data/how_to_play_data.dart';
import 'package:imposter/features/how_to_play/presentation/widgets/how_to_play_rule_widget.dart';

class HowToPlaySectionWidget extends StatelessWidget {
  const HowToPlaySectionWidget({
    required this.section,
    required this.isLastSection,
    required this.startingStepNumber,
    super.key,
  });

  final HowToPlaySection section;
  final bool isLastSection;
  final int startingStepNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.p(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextWidget(
            section.title,
            style: AppTextStyles.font24W700Primary,
          ),
          const AppGap(12),
          ...List.generate(section.rules.length, (index) {
            return HowToPlayRuleWidget(
              rule: section.rules[index],
              stepNumber: startingStepNumber + index,
            );
          }),
          if (!isLastSection) 
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.p(12)),
              child: SizedBox(
                width: double.infinity,
                height: context.h(4),
                child: const CustomPaint(
                  painter: SketchyHorizontalLinePainter(
                    color: AppColors.secondaryBackground,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
