import 'dart:math';
import 'package:flutter/material.dart';
import 'package:imposter/core/style/theme/app_colors.dart';

class AppLoadingIndicator extends StatefulWidget {
  const AppLoadingIndicator({
    super.key,
    this.size = 36,
    this.color = AppColors.primary,
  });

  final double size;
  final Color color;

  @override
  State<AppLoadingIndicator> createState() => _AppLoadingIndicatorState();
}

class _AppLoadingIndicatorState extends State<AppLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: _controller,
        child: SizedBox(
          width: widget.size,
          height: widget.size,
          child: CustomPaint(
            painter: _SketchySpinnerPainter(color: widget.color),
          ),
        ),
      ),
    );
  }
}

class _SketchySpinnerPainter extends CustomPainter {
  _SketchySpinnerPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;

    final path = Path();
    _drawSketchyArc(path, center, radius, 0, 140);
    _drawSketchyArc(path, center, radius, 180, 300);

    canvas.drawPath(path, paint);
  }

  void _drawSketchyArc(
    Path path,
    Offset center,
    double radius,
    double startAngleDeg,
    double endAngleDeg,
  ) {
    final startRad = startAngleDeg * pi / 180;
    final endRad = endAngleDeg * pi / 180;
    const step = 4.0 * pi / 180;

    var currentAngle = startRad;
    var isFirst = true;

    while (currentAngle <= endRad) {
      final ripple = 0.8 * sin(currentAngle * 10);
      final r = radius + ripple;
      final x = center.dx + r * cos(currentAngle);
      final y = center.dy + r * sin(currentAngle);

      if (isFirst) {
        path.moveTo(x, y);
        isFirst = false;
      } else {
        path.lineTo(x, y);
      }
      currentAngle += step;
    }
  }

  @override
  bool shouldRepaint(covariant _SketchySpinnerPainter oldDelegate) =>
      oldDelegate.color != color;
}

