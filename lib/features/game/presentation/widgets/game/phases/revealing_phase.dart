import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/presentation/widgets/app_sketchy_card/app_sketchy_card.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class RevealingPhaseWidget extends StatelessWidget {
  const RevealingPhaseWidget({
    required this.isSpy,
    required this.secretWord,
    required this.categoryName,
    required this.onNext,
    super.key,
  });
  final bool isSpy;
  final String secretWord;
  final String categoryName;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final buttonHeight = (context.height * 0.1).clamp(50.0, 70.0);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (isSpy)
          const _SpyRevealView()
        else
          _CitizenRevealView(category: categoryName, word: secretWord),
        AppButton(
          width: double.infinity.clamp(150, 300),
          height: buttonHeight,
          title: AppStrings.next,
          onTap: onNext,
        ),
      ],
    );
  }
}

class _SpyRevealView extends StatelessWidget {
  const _SpyRevealView();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTextWidget(
          AppStrings.youAreTheSpy,
          style: AppTextStyles.font60W700Primary,
        ).animate().fadeIn(duration: 800.ms).slideY(begin: -0.2, end: 0),
        AppGap(context.p(40)),
      ],
    );
  }
}

class _CitizenRevealView extends StatelessWidget {
  const _CitizenRevealView({required this.category, required this.word});
  final String category;
  final String word;

  @override
  Widget build(BuildContext context) {
    return AppSketchyCard(
      height: 150,
      width: context.w(100),
      title: word,
      style: AppTextStyles.font45W700SecretWord,
    );
  }
}
