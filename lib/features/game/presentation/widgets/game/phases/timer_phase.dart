import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/game_timer.dart';

class TimerPhaseWidget extends StatelessWidget {
  const TimerPhaseWidget({
    required this.durationMinutes,
    required this.onTimeout,
    required this.onFinishTurn,
    super.key,
  });
  final int durationMinutes;
  final VoidCallback onTimeout;
  final VoidCallback onFinishTurn;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Center(
          child: GameTimer(
            duration: Duration(minutes: durationMinutes),
            onTimeout: onTimeout,
          ),
        ),

        AppButton(
          title: AppStrings.startVoting,
          onTap: onFinishTurn,
        ),
      ],
    );
  }
}
