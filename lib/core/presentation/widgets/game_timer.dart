import 'dart:async';

import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/widgets/app_analog_clock.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

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

class _GameTimerState extends State<GameTimer> with TickerProviderStateMixin {
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
    return AnimatedBuilder(
      animation: _timerController,
      builder: (context, _) {
        final progress = _timerController.value;
        final remaining = widget.duration.inSeconds * (1.0 - progress);
        final totalSeconds = remaining.ceil();
        final mins = totalSeconds ~/ 60;
        final secs = totalSeconds % 60;
        final timeStr =
            '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';

        return context.isLandscape
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                spacing: context.p(24),
                children: [
                  RepaintBoundary(
                    child: AppAnalogClock(
                      size: context.s(150),
                      value: progress,
                    ),
                  ),
                  AppTextWidget(
                    timeStr,
                    style: AppTextStyles.font48W400Primary,
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                spacing: context.p(24),
                children: [
                  RepaintBoundary(
                    child: AppAnalogClock(
                      size: context.s(180),
                      value: progress,
                    ),
                  ),
                  AppTextWidget(
                    timeStr,
                    style: AppTextStyles.font48W400Primary,
                  ),
                ],
              );
      },
    );
  }
}
