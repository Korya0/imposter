import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imposter/core/presentation/painters/sketchy_input_painter.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class WobblyNumericAdjuster extends StatelessWidget {
  const WobblyNumericAdjuster({
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
    super.key,
  });

  final int value;
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.h(46),
      child: CustomPaint(
        painter: SketchyInputPainter(
          color: AppColors.primary,
          fillColor: AppColors.secondaryBackground,
          strokeWidth: 1.8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Decrement Button
            _AdjusterButton(
              icon: Icons.remove_sharp,
              onPressed: onDecrement,
            ),

            // Central Numeric Value
            AppTextWidget(
              value.toString(),
              style: AppTextStyles.font24W700Primary,
            ),

            // Increment Button
            _AdjusterButton(
              icon: Icons.add_sharp,
              onPressed: onIncrement,
            ),
          ],
        ),
      ),
    );
  }
}

class _AdjusterButton extends StatefulWidget {
  const _AdjusterButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  State<_AdjusterButton> createState() => _AdjusterButtonState();
}

class _AdjusterButtonState extends State<_AdjusterButton> {
  Timer? _timer;
  Timer? _delayTimer;

  void _startRepeating() {
    if (widget.onPressed == null) return;

    HapticFeedback.lightImpact();
    widget.onPressed!();

    _delayTimer = Timer(const Duration(milliseconds: 400), () {
      _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (widget.onPressed != null) {
          HapticFeedback.lightImpact();
          widget.onPressed!();
        } else {
          _stopRepeating();
        }
      });
    });
  }

  void _stopRepeating() {
    _delayTimer?.cancel();
    _timer?.cancel();
    _delayTimer = null;
    _timer = null;
  }

  @override
  void dispose() {
    _stopRepeating();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null;
    final activeColor = isEnabled
        ? AppColors.primary
        : AppColors.primary.withValues(alpha: 0.3);

    return GestureDetector(
      onTapDown: isEnabled ? (_) => _startRepeating() : null,
      onTapUp: isEnabled ? (_) => _stopRepeating() : null,
      onTapCancel: isEnabled ? _stopRepeating : null,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: context.w(38),
        height: double.infinity,
        child: Icon(
          widget.icon,
          color: activeColor,
          size: context.s(22),
        ),
      ),
    );
  }
}
