import 'package:flutter/material.dart';

class SketchyCirclePainter extends CustomPainter {
  const SketchyCirclePainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final primaryPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, 0, 6.28, false, primaryPaint);

    final outerRect = Rect.fromCircle(center: center, radius: radius + 3);
    final shadowPaint = Paint()
      ..color = color.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(outerRect, 0.45, 5.8, false, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant SketchyCirclePainter oldDelegate) =>
      oldDelegate.color != color;
}
