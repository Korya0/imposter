import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/utils/haptic_feedback_helper.dart';

class GameFingerprintButton extends StatefulWidget {
  const GameFingerprintButton({
    required this.onTap,
    this.onHoldStart,
    this.onHoldCancel,
    super.key,
  });

  final VoidCallback onTap;
  final VoidCallback? onHoldStart;
  final VoidCallback? onHoldCancel;

  @override
  State<GameFingerprintButton> createState() => _GameFingerprintButtonState();
}

class _GameFingerprintButtonState extends State<GameFingerprintButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isPressed = false;
  Timer? _hapticTimer;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 1500),
          )
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) async {
            if (status == AnimationStatus.completed) {
              _stopHaptics();
              await HapticFeedbackHelper.successPattern();
              widget.onTap();
            }
          });
  }

  void _startHaptics() {
    _hapticTimer?.cancel();
    _hapticTimer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      HapticFeedbackHelper.light();
    });
  }

  void _stopHaptics() {
    _hapticTimer?.cancel();
    _hapticTimer = null;
  }

  void _handleHoldStart() {
    if (_controller.isCompleted) return;
    setState(() => _isPressed = true);
    widget.onHoldStart?.call();
    _startHaptics();
    _controller.forward(from: 0);
  }

  void _handleHoldCancel() {
    if (_controller.isCompleted) return;
    setState(() => _isPressed = false);
    _stopHaptics();
    _controller.reverse();
    widget.onHoldCancel?.call();
  }

  @override
  void dispose() {
    _controller.dispose();
    _stopHaptics();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'أبصم لتعريف الهوية',
      button: true,
      enabled: true,
      child: GestureDetector(
        onTapDown: (_) => _handleHoldStart(),
        onTapUp: (_) => _handleHoldCancel(),
        onTapCancel: _handleHoldCancel,
        behavior: HitTestBehavior.opaque,
        child: RepaintBoundary(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.p(40),
              vertical: context.p(20),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Glowing background aura when active
                AnimatedContainer(
                  duration: 200.ms,
                  width: context.s(120),
                  height: context.s(120),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: _isPressed
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 20,
                              spreadRadius: 4,
                            ),
                          ]
                        : [],
                  ),
                ),
                // Luxurious Gold Radial Progress Ring
                SizedBox(
                  width: context.s(120),
                  height: context.s(120),
                  child: CircularProgressIndicator(
                    value: _controller.value,
                    strokeWidth: 4,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  ),
                ),
                // Animated Fingerprint SVG
                _FingerprintContent(isPressed: _isPressed),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FingerprintContent extends StatelessWidget {
  const _FingerprintContent({required this.isPressed});
  final bool isPressed;

  @override
  Widget build(BuildContext context) {
    final scanColor = isPressed
        ? AppColors.primary
        : AppColors.primary.withValues(alpha: 0.7);

    final svgPicture = SvgPicture.asset(
      AppAssets.fingerprintSvg,
      height: context.s(70),
      colorFilter: ColorFilter.mode(scanColor, BlendMode.srcIn),
    );

    return isPressed
        ? svgPicture.animate().scale(
            begin: const Offset(1, 1),
            end: const Offset(1.15, 1.15),
            duration: 150.ms,
            curve: Curves.easeOut,
          )
        : svgPicture;
  }
}
