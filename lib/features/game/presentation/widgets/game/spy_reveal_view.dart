import 'package:flutter/material.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/presentation/widgets/game/spy_logo.dart';
import 'package:imposter/features/game/presentation/widgets/game/spy_you_are_text.dart';

class SpyRevealView extends StatelessWidget {
  const SpyRevealView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SpyYouAreText(),
        SizedBox(height: (context.height * 0.05).clamp(14, 40)),
        const SpyLogo(),
      ],
    );
  }
}
