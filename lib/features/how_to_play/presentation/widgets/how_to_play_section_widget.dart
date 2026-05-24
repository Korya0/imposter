import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/widgets/app_divider.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextWidget(
          section.title,
        ),
        const AppGap(12),
        ...List.generate(section.rules.length, (index) {
          return HowToPlayRuleWidget(
            rule: section.rules[index],
            stepNumber: startingStepNumber + index,
          );
        }),
        if (!isLastSection) const AppDivider(),
      ],
    );
  }
}
