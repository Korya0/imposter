import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/widgets/app_sketchy_card/app_sketchy_card.dart';
import 'package:imposter/core/widgets/app_text_widget.dart';
import 'package:imposter/features/game/widgets/game_next_button.dart';

class CitizenRevealView extends StatelessWidget {
  final VoidCallback onNext;
  final String secretWord;
  const CitizenRevealView({
    super.key,
    required this.onNext,
    this.secretWord = 'مسجد',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        AppTextWidget(
          AppStrings.youAreNotTheSpy,
          style: AppTextStyles.font24W800Primary,
        ),
        const SizedBox(height: 20),
        AppSketchyCard(
          title: secretWord,
        ),
        const Spacer(),
        GameNextButton(onPressed: onNext),
        SizedBox(height: (context.height * 0.05).clamp(12, 32)),
      ],
    );
  }
}
