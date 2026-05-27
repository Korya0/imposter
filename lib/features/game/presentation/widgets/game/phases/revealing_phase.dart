import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_padding.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/presentation/widgets/app_sketchy_card/app_sketchy_card.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';

class RevealingPhaseWidget extends StatelessWidget {
  const RevealingPhaseWidget({
    required this.isSpy,
    required this.secretWord,
    required this.onNext,
    super.key,
  });
  final bool isSpy;
  final String secretWord;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.viewH22(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const AppGap(0),
          if (isSpy)
            AppTextWidget(
              AppStrings.youAreTheSpy,
              style: AppTextStyles.fontSecond50W700Primary,
            )
                .animate()
                .fadeIn(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                )
                .scale(
                  begin: const Offset(0.7, 0.7),
                  end: const Offset(1, 1),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.elasticOut,
                )
          else
            AppSketchyCard(
              title: secretWord,
            )
                .animate()
                .fadeIn(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOut,
                )
                .scale(
                  begin: const Offset(0.9, 0.9),
                  end: const Offset(1, 1),
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOutBack,
                ),

          const AppGap(0),
          AppButton(
            title: AppStrings.next,
            onTap: onNext,
          )
              .animate()
              .fadeIn(
                delay: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 350),
              )
              .slideY(
                begin: 0.1,
                end: 0,
                delay: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutQuad,
              ),
        ],
      ),
    );
  }
}
