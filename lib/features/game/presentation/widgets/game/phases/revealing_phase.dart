import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_sketchy_card/app_sketchy_card.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class RevealingPhaseWidget extends StatelessWidget {
  const RevealingPhaseWidget({
    required this.isSpy,
    required this.secretWord,
    required this.categoryName,
    super.key,
  });
  final bool isSpy;
  final String secretWord;
  final String categoryName;

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
     /*   const AppLogoHeader(
     //     showText: false,
        ).animate().fadeIn(delay: 400.ms, duration: 800.ms).slideY(begin: 0.2, end: 0),
   */   ],
    );
  }
}

class _SpyYouAreText extends StatelessWidget {
  const _SpyYouAreText();

  @override
  Widget build(BuildContext context) {
    return AppTextWidget(
      AppStrings.youAreTheSpy,
      style: AppTextStyles.font60W700Primary,
    ).animate().fadeIn(duration: 800.ms).slideY(begin: -0.2, end: 0);
  }
}

class _CitizenRevealView extends StatelessWidget {
  const _CitizenRevealView({
    required this.category,
    required this.word,
  });
  final String category;
  final String word;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              AppTextWidget(
                '${AppStrings.category}:',
                style: AppTextStyles.font28W700Primary,
              ),
              AppTextWidget(
                category,
                style: AppTextStyles.font28W400White,
              ),
            ],
          ),
          // EXCEPTION: Use a regular system sans-serif font family for the secret word
          // to ensure clear gameplay readability and avoid any calligraphic styling confusion.
          // استثناء: استخدام خط عادي (sans-serif) للكلمة السرية لضمان الوضوح التام ومنع اللبس.
          AppSketchyCard(
            height: 150,
            title: word,
            style: AppTextStyles.font45W700Primary.copyWith(
              fontFamily: 'sans-serif',
            ),
          ),
        ],
      ),
    );
  }
}
