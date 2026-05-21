import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/game_timer.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

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
    final buttonHeight = (context.height * 0.1).clamp(50.0, 70.0);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: GameTimer(
            duration: Duration(minutes: durationMinutes),
            onTimeout: onTimeout,
          ),
        ),
        AppButton(
          width: double.infinity.clamp(150, 300),
          height: buttonHeight,
          title: AppStrings.finishTurn,
          onTap: onFinishTurn,
        ),
      ],
    );
  }
}
