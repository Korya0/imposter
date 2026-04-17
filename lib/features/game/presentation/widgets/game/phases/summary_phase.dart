import 'package:flutter/material.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_summary_view.dart';

class SummaryPhaseWidget extends StatelessWidget {
  final String secretWord;
  final int playerCount;
  final int spyCount;
  final int durationMinutes;
  final VoidCallback onAnotherRound;
  final VoidCallback onFinish;

  const SummaryPhaseWidget({
    super.key,
    required this.secretWord,
    required this.playerCount,
    required this.spyCount,
    required this.durationMinutes,
    required this.onAnotherRound,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return GameSummaryView(
      secretWord: secretWord,
      playersCount: playerCount,
      spiesCount: spyCount,
      duration: Duration(minutes: durationMinutes),
      onAnotherRound: onAnotherRound,
      onFinish: onFinish,
    );
  }
}
