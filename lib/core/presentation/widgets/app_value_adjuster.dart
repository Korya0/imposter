import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';

class AppValueAdjuster extends StatelessWidget {
  const AppValueAdjuster({
    required this.value,
    super.key,
    this.onIncrement,
    this.onDecrement,
    this.width = 70,
    this.textColor,
    this.buttonColor,
  });
  final String value;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final double? width;
  final Color? textColor;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    final activeTextColor = textColor ?? AppColors.primary;
    final activeBtnColor = buttonColor ?? AppColors.primary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TactileSketchyIconButton(
          icon: Icons.add_sharp,
          color: activeBtnColor,
          onPressed: onIncrement,
        ),
        SizedBox(
          width: width,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: AppTextWidget(
              value,
              style: AppTextStyles.font40W700Primary.copyWith(
                color: activeTextColor,
              ),
            ),
          ),
        ),
        TactileSketchyIconButton(
          icon: Icons.remove_sharp,
          color: activeBtnColor,
          onPressed: onDecrement,
        ),
      ],
    );
  }
}

class TactileSketchyIconButton extends StatefulWidget {
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
  State<TactileSketchyIconButton> createState() => _TactileSketchyIconButtonState();
}

class _TactileSketchyIconButtonState extends State<TactileSketchyIconButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null;
    final activeColor = isEnabled ? widget.color : widget.color.withValues(alpha: 0.3);

    return GestureDetector(
      onTapDown: (_) {
        if (isEnabled) {
          setState(() {
            _isPressed = true;
          });
        }
      },
      onTapUp: (_) {
        if (isEnabled) {
          setState(() {
            _isPressed = false;
          });
        }
      },
      onTapCancel: () {
        if (isEnabled) {
          setState(() {
            _isPressed = false;
          });
        }
      },
      onTap: isEnabled
          ? () {
              HapticFeedback.lightImpact();
              widget.onPressed!();
            }
          : null,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _isPressed ? 0.90 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOutCubic,
        child: Container(
          width: 44,
          height: 44,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: CustomPaint(
            painter: QuietSketchyPainter(color: activeColor),
            child: Center(
              child: Icon(
                widget.icon,
                size: 22,
                color: activeColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QuietSketchyPainter extends CustomPainter {
  QuietSketchyPainter({required this.color});
  final Color color;

  static Path? _cachedPath;

  static Path _buildPath(double radius, Offset center) {
    final path = Path();
    for (var i = 0; i <= 360; i += 8) {
      final angle = i * 3.14159265 / 180;
      final ripple = 0.9 * (sin(angle * 6) + cos(angle * 4));
      final r = radius - 1.5 + ripple;
      final x = center.dx + r * cos(angle);
      final y = center.dy + r * sin(angle);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);
    
    // Retrieve cached path to avoid heavy frame-by-frame trigonometric evaluations
    _cachedPath ??= _buildPath(radius, center);

    canvas.drawPath(_cachedPath!, paint);
  }

  @override
  bool shouldRepaint(covariant QuietSketchyPainter oldDelegate) =>
      oldDelegate.color != color;
}
