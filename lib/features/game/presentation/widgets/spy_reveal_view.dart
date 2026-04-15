import 'package:flutter/material.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/presentation/widgets/game_next_button.dart';
import 'package:imposter/features/game/presentation/widgets/spy_logo.dart';
import 'package:imposter/features/game/presentation/widgets/spy_you_are_text.dart';

class SpyRevealView extends StatelessWidget {
  final VoidCallback onNext;
  const SpyRevealView({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        const SpyYouAreText(),
        SizedBox(height: (context.height * 0.05).clamp(14, 40)),
        const SpyLogo(),
        const Spacer(),
        GameNextButton(onPressed: onNext),
        SizedBox(height: (context.height * 0.05).clamp(12, 32)),
      ],
    );
  }
}
