import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_padding.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/presentation/widgets/app_sketchy_card/app_sketchy_card.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
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
          else
            AppSketchyCard(
              title: secretWord,
            ),

          const AppGap(0),
          AppButton(
            title: AppStrings.next,
            onTap: onNext,
          ),
        ],
      ),
    );
  }
}
