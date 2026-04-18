import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_logo_header.dart';
import 'package:imposter/core/presentation/widgets/app_sketchy_card/app_sketchy_card.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class RevealingPhaseWidget extends StatelessWidget {
  final bool isSpy;
  final String secretWord;
  final String categoryName;

  const RevealingPhaseWidget({
    super.key,
    required this.isSpy,
    required this.secretWord,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    if (isSpy) {
      return const _SpyRevealView();
    }
    return _CitizenRevealView(
      category: categoryName,
      word: secretWord,
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
        const _SpyYouAreText(),
        const SizedBox(height: 10),
        SizedBox(height: (context.height * 0.05).clamp(14, 40)),
        const AppLogoHeader(
          shouldAnimate: true,
          showText: false,
        ),
      ],
    );
  }
}

class _SpyYouAreText extends StatelessWidget {
  const _SpyYouAreText();

  @override
  Widget build(BuildContext context) {
    return AppTextWidget(
      AppStrings.youAreTheSpy,
      style: AppTextStyles.ruqaa60BoldPrimary,
    ).animate().fadeIn(duration: 800.ms).slideY(begin: -0.2, end: 0);
  }
}

class _CitizenRevealView extends StatelessWidget {
  final String category;
  final String word;

  const _CitizenRevealView({
    required this.category,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSketchyCard(
            height: 150,
            title: word,
            style: AppTextStyles.font45W800Primary,
          ),
        ],
      ),
    );
  }
}
