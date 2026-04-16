import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/presentation/widgets/app_sketchy_card/app_sketchy_card.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';

class CitizenRevealView extends StatelessWidget {
  final String word;

  const CitizenRevealView({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextWidget(
            AppStrings.youAreNotTheSpy,
            style: AppTextStyles.ruqaa24BoldPrimary,
          ),
          const SizedBox(height: 5),
          AppSketchyCard(
            height: 150,
            title: word,
          ),
        ],
      ),
    );
  }
}
