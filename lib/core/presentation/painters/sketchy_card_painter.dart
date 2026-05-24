import 'dart:math';

import 'package:flutter/material.dart';

class SketchyCardPainter extends CustomPainter {
  SketchyCardPainter({
    required this.color,
    this.showTape = true,
  }) {
    _borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2
      ..strokeCap = StrokeCap.round;

    _scribblePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    _tapeFillPaint = Paint()..style = PaintingStyle.fill;
    _tapeStrokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
  }
  late final Paint _borderPaint;
  late final Paint _scribblePaint;
  late final Paint _tapeFillPaint;
  late final Paint _tapeStrokePaint;
  final Random _random = Random(42);

  final Color color;
  final bool showTape;

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < 3; i++) {
      _borderPaint.color = color.withValues(alpha: 0.2 + (i * 0.1));

      final offset = (_random.nextDouble() - 0.5) * 8;
      final path = Path()
        ..moveTo(offset, offset)
        ..lineTo(size.width + offset, offset)
        ..lineTo(size.width + offset, size.height + offset)
        ..lineTo(offset, size.height + offset)
        ..close();

      canvas.drawPath(path, _borderPaint);
    }

    _drawCornerScribbles(canvas, size);

    if (showTape) {
      _drawSketchyTape(canvas, size);
    }
  }

  void _drawCornerScribbles(Canvas canvas, Size size) {
    _scribblePaint.color = color.withValues(alpha: 0.6);

    canvas
      ..drawLine(
        Offset(size.width - 15, -5),
        Offset(size.width + 5, 10),
        _scribblePaint,
      )
      ..drawLine(
        Offset(size.width - 5, -10),
        Offset(size.width + 10, 5),
        _scribblePaint,
      );
  }

  void _drawSketchyTape(Canvas canvas, Size size) {
    final tapeW = size.width * 0.35;
    const tapeH = 25;
    final centerX = size.width / 2;

    final offsetX = (_random.nextDouble() - 0.5) * 5;

    final tapePath = Path()
      ..moveTo(centerX - tapeW / 2 + offsetX, -15)
      ..lineTo(centerX + tapeW / 2 + offsetX, -10)
      ..lineTo(centerX + tapeW / 2 + offsetX, tapeH - 10)
      ..lineTo(centerX - tapeW / 2 + offsetX, tapeH - 15)
      ..close();

    _tapeFillPaint.color = color.withValues(alpha: 0.3);
    _tapeStrokePaint.color = color.withValues(alpha: 0.4);

    canvas
      ..drawPath(tapePath, _tapeFillPaint)
      ..drawPath(tapePath, _tapeStrokePaint);
  }

  @override
  bool shouldRepaint(covariant SketchyCardPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.showTape != showTape;
}
