import 'package:flutter/material.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_ready_view.dart';

class ReadyPhaseWidget extends StatelessWidget {
  final VoidCallback onStartTimer;

  const ReadyPhaseWidget({
    super.key,
    required this.onStartTimer,
  });

  @override
  Widget build(BuildContext context) {
    return GameReadyView(onStartTimer: onStartTimer);
  }
}
