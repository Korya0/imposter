import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/widgets/app_logo_header.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/presentation/widgets/game/spy_you_are_text.dart';

class SpyRevealView extends StatelessWidget {
  const SpyRevealView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SpyYouAreText(),
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
