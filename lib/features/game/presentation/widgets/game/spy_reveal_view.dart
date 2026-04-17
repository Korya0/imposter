import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/presentation/widgets/app_logo_header.dart';
import 'package:imposter/features/game/presentation/widgets/game/spy_you_are_text.dart';

class SpyRevealView extends StatelessWidget {
  final String category;

  const SpyRevealView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SpyYouAreText(),
        const SizedBox(height: 10),
        AppTextWidget(
          '($category)',
          style: AppTextStyles.font22W200White,
        ),
        SizedBox(height: (context.height * 0.05).clamp(14, 40)),
        const AppLogoHeader(
          shouldAnimate: true,
          showText: false,
        ),
      ],
    );
  }
}
