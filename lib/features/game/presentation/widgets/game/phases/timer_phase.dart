import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/widgets/game_timer.dart';

class TimerPhaseWidget extends StatelessWidget {
  const TimerPhaseWidget({
    required this.durationMinutes,
    required this.onTimeout,
    super.key,
  });
  final int durationMinutes;
  final VoidCallback onTimeout;

  @override
  Widget build(BuildContext context) {
    return GameTimer(
      duration: Duration(minutes: durationMinutes),
      onTimeout: onTimeout,
    );
  }
}
