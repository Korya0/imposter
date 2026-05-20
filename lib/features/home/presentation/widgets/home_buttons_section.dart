import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/show_how_to_play_sheet.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class HomeButtonsSection extends StatelessWidget {
  final VoidCallback onFeedbackTap;

  const HomeButtonsSection({
    required this.onFeedbackTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscape = context.isLandscape;

    final letsGoButton = AppButton(
      width: isLandscape ? context.w(300) : null,
      title: AppStrings.letsGo,
      onTap: () {
        context.pushNamed(AppRoutes.topicsSelection);
      },
    );

    final howToPlayButton = AppButton(
      title: AppStrings.howToPlay,
      style: AppTextStyles.font32W700Secondary,
      onTap: () => showHowToPlaySheet(context),
    );

    final tellUsButton = AppButton(
      title: AppStrings.tellUs,
      style: AppTextStyles.font32W700Secondary,
      onTap: onFeedbackTap,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: context.p(18),
      children: [
        letsGoButton,
        Row(
          spacing: context.p(12),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLandscape)
              SizedBox(width: context.w(144), child: howToPlayButton)
            else
              Expanded(child: howToPlayButton),
            if (isLandscape)
              SizedBox(width: context.w(144), child: tellUsButton)
            else
              Expanded(child: tellUsButton),
          ],
        ),
      ],
    );
  }
}
