import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imposter/core/presentation/painters/quiet_sketchy_painter.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class TactileSketchyIconButton extends StatelessWidget {
  const TactileSketchyIconButton({
    required this.icon,
    required this.onPressed,
    required this.color,
    super.key,
  });

  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;
    final activeColor = isEnabled ? color : color.withValues(alpha: 0.3);

    return GestureDetector(
      onTap: isEnabled
          ? () {
              HapticFeedback.lightImpact();
              onPressed!();
            }
          : null,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: context.w(44),
        height: context.h(44),
        margin: EdgeInsets.symmetric(horizontal: context.p(4)),
        child: CustomPaint(
          painter: QuietSketchyPainter(color: activeColor),
          child: Center(
            child: Icon(
              icon,
              size: context.s(22),
              color: activeColor,
            ),
          ),
        ),
      ),
    );
  }
}


