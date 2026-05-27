import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
          )
              .animate()
              .fadeIn(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOut,
              )
              .scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1, 1),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutBack,
              ),
        ),

        AppButton(
          title: AppStrings.startVoting,
          onTap: onFinishTurn,
        )
            .animate()
            .fadeIn(
              delay: const Duration(milliseconds: 250),
              duration: const Duration(milliseconds: 350),
            )
            .slideY(
              begin: 0.15,
              end: 0,
              delay: const Duration(milliseconds: 250),
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutQuad,
            ),
      ],
    );
  }
}
