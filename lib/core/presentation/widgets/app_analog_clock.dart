import 'dart:math';

import 'package:flutter/material.dart';
import 'package:imposter/core/theme/app_colors.dart';

class AppAnalogClock extends StatelessWidget {
  final double value; // From 0.0 to 1.0 (Animation progress)
  final double size;

  const AppAnalogClock({
    super.key,
    required this.value,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ClockPainter(
          value: value,
          primaryColor: AppColors.primary,
          secondaryColor: AppColors.white,
        ),
      ),
    );
  }
}

class _ClockPainter extends CustomPainter {
  final double value;
  final Color primaryColor;
  final Color secondaryColor;

  _ClockPainter({
    required this.value,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    final outerCirclePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final innerCirclePaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    // Draw Outer Circle
    canvas
      ..drawCircle(center, radius, outerCirclePaint)
      ..drawCircle(center, radius, innerCirclePaint);

    // Draw Hour Markers
    final markerPaint = Paint()
      ..color = primaryColor
      ..strokeWidth = 2;

    for (var i = 0; i < 12; i++) {
      final angle = (i * 30) * pi / 180;
      final start = Offset(
        center.dx + (radius - 10) * cos(angle),
        center.dy + (radius - 10) * sin(angle),
      );
      final end = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      canvas.drawLine(start, end, markerPaint);
    }

    // Animation progress logic
    // We'll simulate hands based on the value (0.0 = start, 1.0 = end)

    // Minute Hand (Slow)
    final minuteAngle = (value * 360 - 90) * pi / 180;
    final minuteHandPaint = Paint()
      ..color = secondaryColor
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      center,
      Offset(
        center.dx + (radius * 0.6) * cos(minuteAngle),
        center.dy + (radius * 0.6) * sin(minuteAngle),
      ),
      minuteHandPaint,
    );

    // Second Hand (Fast - it will rotate multiple times based on total seconds)
    // For a generic "moving" effect, we use a multiplier
    final secondAngle = (value * 360 * 60 - 90) * pi / 180;
    final secondHandPaint = Paint()
      ..color = primaryColor
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas
      ..drawLine(
        center,
        Offset(
          center.dx + (radius * 0.8) * cos(secondAngle),
          center.dy + (radius * 0.8) * sin(secondAngle),
        ),
        secondHandPaint,
      )
      // Center Dot
      ..drawCircle(center, 6, Paint()..color = primaryColor)
      ..drawCircle(center, 3, Paint()..color = secondaryColor);
  }

  @override
  bool shouldRepaint(covariant _ClockPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
