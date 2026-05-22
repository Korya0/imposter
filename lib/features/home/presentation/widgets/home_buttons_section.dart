import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class HomeButtonsSection extends StatelessWidget {
  const HomeButtonsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: context.p(18),
      children: [
        AppButton(
          title: AppStrings.letsGo,
          style: AppTextStyles.font32W700Secondary,

          onTap: () {
            context.pushNamed(AppRoutes.topicsSelection);
          },
        ),
        Row(
          spacing: context.p(12),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: AppButton(
                title: AppStrings.howToPlay,
                onTap: () {
                  context.pushNamed(AppRoutes.howToPlay);
                },
              ),
            ),
            Expanded(
              child: AppButton(
                title: AppStrings.tellUs,
                onTap: () {
                  context.pushNamed(AppRoutes.feedback);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
