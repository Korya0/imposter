import 'dart:async';
import 'package:flutter/material.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';

import 'package:imposter/core/presentation/widgets/app_analog_clock.dart';

class GameTimer extends StatefulWidget {
  const GameTimer({
    required this.duration,
    required this.onTimeout,
    super.key,
  });
  final Duration duration;
  final VoidCallback onTimeout;

  @override
  State<GameTimer> createState() => _GameTimerState();
}

class _GameTimerState extends State<GameTimer>
    with TickerProviderStateMixin {
  late AnimationController _timerController;

  @override
  void initState() {
    super.initState();
    _timerController =
        AnimationController(vsync: this, duration: widget.duration)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) _explode();
          });
    unawaited(_timerController.forward());
  }

  void _explode() {
    if (!mounted) return;
    widget.onTimeout();
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _timerController,
          builder: (context, _) {
            final progress = _timerController.value;
            final remaining = widget.duration.inSeconds * (1.0 - progress);
            final totalSeconds = remaining.ceil();
            final mins = totalSeconds ~/ 60;
            final secs = totalSeconds % 60;
            final timeStr =
                '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';

            return Column(
              children: [
                RepaintBoundary(
                  child: AppAnalogClock(
                    value: progress,
                    size: 220,
                  ),
                ),
                const SizedBox(height: 30),
                AppTextWidget(
                  timeStr,
                  style: AppTextStyles.ruqaa48W400Primary,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
