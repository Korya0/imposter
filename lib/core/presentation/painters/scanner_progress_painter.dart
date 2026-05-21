import 'package:flutter/material.dart';
import 'dart:math' as math;

class ScannerProgressPainter extends CustomPainter {
  const ScannerProgressPainter({required this.progress, required this.color});
  final double progress;
  final Color color;

  static const double _startAngle = -math.pi / 2;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) + 2;
    final sweepAngle = 2 * math.pi * progress;

    final primaryPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      _startAngle,
      sweepAngle,
      false,
      primaryPaint,
    );

    final accentPaint = Paint()
      ..color = color.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius + 3),
      _startAngle + 0.1,
      sweepAngle * 0.95,
      false,
      accentPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ScannerProgressPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
