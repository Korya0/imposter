import 'dart:async';
import 'package:flutter/material.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/widgets/app_text_widget.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/widgets/app_button.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:lottie/lottie.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';

class LottieTimer extends StatefulWidget {
  const LottieTimer({
    required this.duration,
    required this.onTimeout,
    required this.onFinish,
    super.key,
  });
  final Duration duration;
  final VoidCallback onTimeout;
  final VoidCallback onFinish;

  @override
  State<LottieTimer> createState() => _LottieTimerState();
}

class _LottieTimerState extends State<LottieTimer>
    with TickerProviderStateMixin {
  late AnimationController _timerController;
  bool _hasExploded = false;

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
    setState(() => _hasExploded = true);
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
      children: [
        SizedBox(
          width: 150,
          height: 150,
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
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        if (!_hasExploded) ...[
          const SizedBox(height: 10),
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
                style: AppTextStyles.font22W200Primary.copyWith(
                  color: Colors.red,
                ),
              );
            },
          ),
          const Spacer(),
          AppButton(
            width: 250,
            height: (context.height * 0.1).clamp(50, 70),
            title: AppStrings.finishTurn,
            onTap: widget.onFinish,
          ),
          SizedBox(height: (context.height * 0.05).clamp(12, 32)),
        ] else ...[
          const SizedBox(height: 24),
          AppTextWidget(
            AppStrings.roundEnded,
            style: AppTextStyles.font22W200Primary,
          ),
          const SizedBox(height: 32),
          AppButton(
            width: 250,
            height: (context.height * 0.1).clamp(50, 70),
            title: AppStrings.finishGame,
            onTap: widget.onFinish,
          ),
        ],
      ],
    );
  }
}
