import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/how_to_play/presentation/widgets/sketchy_horizontal_line_painter.dart';
import 'package:imposter/features/how_to_play/presentation/widgets/how_to_play_step_row.dart';

class RuleCategory {
  final String title;
  final List<int> stepIndexes;

  const RuleCategory({
    required this.title,
    required this.stepIndexes,
  });
}

class HowToPlayCategorySection extends StatelessWidget {
  const HowToPlayCategorySection({
    required this.category,
    required this.isLast,
    super.key,
  });

  final RuleCategory category;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: context.p(8), bottom: context.p(16)),
          child: AppTextWidget(
            category.title,
            style: AppTextStyles.font24W700Primary,
          ),
        ),
        ...category.stepIndexes.map((index) {
          final step = AppStrings.howToPlaySteps[index];
          return HowToPlayStepRow(
            index: index,
            stepText: step,
          );
        }),
        if (!isLast)
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
    );
  }
}
