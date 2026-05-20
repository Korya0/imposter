import 'dart:math';
import 'package:flutter/material.dart';

class SketchyHorizontalLinePainter extends CustomPainter {
  const SketchyHorizontalLinePainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final path = Path()..moveTo(0, size.height / 2);

    const steps = 24;
    final stepWidth = size.width / steps;
    for (var i = 1; i <= steps; i++) {
      final x = i * stepWidth;
      final y = size.height / 2 + 0.8 * sin(i * 1.5);
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant SketchyHorizontalLinePainter oldDelegate) =>
      oldDelegate.color != color;
}
