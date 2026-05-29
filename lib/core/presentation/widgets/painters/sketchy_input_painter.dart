import 'dart:math';

import 'package:flutter/material.dart';

class SketchyInputPainter extends CustomPainter {
  SketchyInputPainter({
    required this.color,
    this.strokeWidth = 2.0,
    this.isFocused = false,
    this.fillColor,
  }) {
    _borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    if (fillColor != null) {
      _fillPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = fillColor!;
    }
  }

  final Color color;
  final double strokeWidth;
  final bool isFocused;
  final Color? fillColor;
  late final Paint _borderPaint;
  Paint? _fillPaint;

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(42);

    // 1. Draw background fill if provided
    if (_fillPaint != null) {
      final fillPath = Path()
        ..moveTo(0, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..close();
      canvas.drawPath(fillPath, _fillPaint!);
    }

    // 2. Draw wobbly outline
    // Loop multiple times for that lovely sketchy ink layered look
    final layers = isFocused ? 3 : 2;
    for (var i = 0; i < layers; i++) {
      _borderPaint.color = isFocused
          ? color.withValues(alpha: 0.5 + (i * 0.25))
          : color.withValues(alpha: 0.2 + (i * 0.15));

      final offset = (random.nextDouble() - 0.5) * (isFocused ? 3.5 : 2.0);
      final path = Path()
        ..moveTo(offset, offset)
        ..lineTo(size.width - offset, offset)
        ..lineTo(size.width - offset, size.height - offset)
        ..lineTo(offset, size.height - offset)
        ..close();

      canvas.drawPath(path, _borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant SketchyInputPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.isFocused != isFocused ||
      oldDelegate.fillColor != fillColor;
}
