import 'dart:async';
import 'package:flutter/material.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/widgets/app_text_widget.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:lottie/lottie.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';

class LottieTimer extends StatefulWidget {
  const LottieTimer({
    required this.duration,
    required this.onTimeout,
    super.key,
  });
  final Duration duration;
  final VoidCallback onTimeout;

  @override
  State<LottieTimer> createState() => _LottieTimerState();
}

class _LottieTimerState extends State<LottieTimer>
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
        SizedBox(
          width: context.width * 0.9,
          height: context.width * 0.9,
          child: DotLottieLoader.fromAsset(
            AppLottie.timer,
            frameBuilder: (ctx, dotlottie) {
              if (dotlottie != null) {
                return ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                  child: Lottie.memory(
                    dotlottie.animations.values.single,
                    controller: _timerController,
                    fit: BoxFit.contain,
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        const SizedBox(height: 20),
        AnimatedBuilder(
          animation: _timerController,
          builder: (context, _) {
            final remaining =
                widget.duration.inSeconds * (1.0 - _timerController.value);
            final totalSeconds = remaining.ceil();
            final mins = totalSeconds ~/ 60;
            final secs = totalSeconds % 60;
            final timeStr =
                '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';

            return AppTextWidget(
              timeStr,
              style: AppTextStyles.ruqaa48W400Primary,
            );
          },
        ),
      ],
    );
  }
}
