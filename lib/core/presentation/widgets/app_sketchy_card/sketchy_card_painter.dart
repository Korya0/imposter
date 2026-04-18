import 'dart:math';

import 'package:flutter/material.dart';

class SketchyCardPainter extends CustomPainter {
  late final Paint _borderPaint;
  late final Paint _scribblePaint;
  late final Paint _tapeFillPaint;
  late final Paint _tapeStrokePaint;
  final Random _random = Random(42);

  SketchyCardPainter({
    required this.color,
    this.showTape = true,
    this.progress = 0.0,
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

  final Color color;
  final bool showTape;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw 3 overlapping messy borders
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

    // 2. Corner Scribbles
    _drawCornerScribbles(canvas, size);

    // 3. INTERNAL SCRIBBLES ON TAP (Progress based)
    if (progress > 0) {
      _drawInternalScribbles(canvas, size);
    }

    // 4. Tape effect
    if (showTape) {
      _drawSketchyTape(canvas, size);
    }
  }

  void _drawInternalScribbles(Canvas canvas, Size size) {
    _scribblePaint.color = color.withValues(alpha: progress * 0.15);

    final lineCount = (30 * progress).toInt();
    for (var i = 0; i < lineCount; i++) {
      final x1 = _random.nextDouble() * size.width;
      final y1 = _random.nextDouble() * size.height;
      final x2 = x1 + (_random.nextDouble() - 0.5) * 40;
      final y2 = y1 + (_random.nextDouble() - 0.5) * 40;

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), _scribblePaint);
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
      oldDelegate.progress != progress;
}
