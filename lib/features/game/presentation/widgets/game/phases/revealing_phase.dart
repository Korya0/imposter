import 'package:flutter/material.dart';
import 'package:imposter/features/game/presentation/widgets/game/citizen_reveal_view.dart';
import 'package:imposter/features/game/presentation/widgets/game/spy_reveal_view.dart';

class RevealingPhaseWidget extends StatelessWidget {
  final bool isSpy;
  final String secretWord;
  final String categoryName;

  const RevealingPhaseWidget({
    super.key,
    required this.isSpy,
    required this.secretWord,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    if (isSpy) {
      return const SpyRevealView();
    }
    return CitizenRevealView(
      category: categoryName,
      word: secretWord,
    );
  }
}
