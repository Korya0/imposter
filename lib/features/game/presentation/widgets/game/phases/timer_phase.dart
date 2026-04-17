import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/widgets/lottie_timer.dart';

class TimerPhaseWidget extends StatelessWidget {
  final int durationMinutes;
  final VoidCallback onTimeout;

  const TimerPhaseWidget({
    super.key,
    required this.durationMinutes,
    required this.onTimeout,
  });

  @override
  Widget build(BuildContext context) {
    return LottieTimer(
      duration: Duration(minutes: durationMinutes),
      onTimeout: onTimeout,
    );
  }
}
