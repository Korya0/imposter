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
    return Column(
      spacing: context.p(18),
      children: [
        AppButton(
          title: AppStrings.letsGo,
          onTap: () {
            context.pushNamed(AppRoutes.topicsSelection);
          },
        ),
        Row(
          spacing: context.p(12),
          children: [
            Expanded(
              child: AppButton(
                title: AppStrings.howToPlay,
                style: AppTextStyles.font32W700Secondary,
                onTap: () => showHowToPlaySheet(context),
              ),
            ),
            Expanded(
              child: AppButton(
                title: AppStrings.tellUs,
                style: AppTextStyles.font32W700Secondary,
                onTap: onFeedbackTap,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
