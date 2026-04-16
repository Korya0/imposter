import 'dart:math';

import 'package:flutter/material.dart';

class SketchyCardPainter extends CustomPainter {
  SketchyCardPainter({
    required this.color,
    this.showTape = true,
    this.progress = 0.0,
  });

  final Color color;
  final bool showTape;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(42);

    // Reuse paint object by modifying its properties
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2
      ..strokeCap = StrokeCap.round;

    // 1. Draw 3 overlapping messy borders
    for (var i = 0; i < 3; i++) {
      paint.color = color.withValues(alpha: 0.2 + (i * 0.1));

      final offset = (random.nextDouble() - 0.5) * 8;
      final path = Path()
        ..moveTo(offset, offset)
        ..lineTo(size.width + offset, offset)
        ..lineTo(size.width + offset, size.height + offset)
        ..lineTo(offset, size.height + offset)
        ..close();

      canvas.drawPath(path, paint);
    }

    // 2. Corner Scribbles
    _drawCornerScribbles(canvas, size, paint, random);

    // 3. INTERNAL SCRIBBLES ON TAP (Progress based)
    if (progress > 0) {
      _drawInternalScribbles(canvas, size, color, progress, random);
    }

    // 4. Tape effect
    if (showTape) {
      _drawSketchyTape(canvas, size, color, random);
    }
  }

  void _drawInternalScribbles(
    Canvas canvas,
    Size size,
    Color color,
    double progress,
    Random random,
  ) {
    final scribblePaint = Paint()
      ..color = color.withValues(alpha: progress * 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final lineCount = (30 * progress).toInt();
    for (var i = 0; i < lineCount; i++) {
      final x1 = random.nextDouble() * size.width;
      final y1 = random.nextDouble() * size.height;
      final x2 = x1 + (random.nextDouble() - 0.5) * 40;
      final y2 = y1 + (random.nextDouble() - 0.5) * 40;

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), scribblePaint);
    }
  }

  void _drawCornerScribbles(
    Canvas canvas,
    Size size,
    Paint paint,
    Random random,
  ) {
    paint
      ..strokeWidth = 1.0
      ..color = color.withValues(alpha: 0.6);

    canvas
      ..drawLine(
        Offset(size.width - 15, -5),
        Offset(size.width + 5, 10),
        paint,
      )
      ..drawLine(
        Offset(size.width - 5, -10),
        Offset(size.width + 10, 5),
        paint,
      );
  }

  void _drawSketchyTape(
    Canvas canvas,
    Size size,
    Color tapeColor,
    Random random,
  ) {
    final tapeW = size.width * 0.35;
    const tapeH = 25;
    final centerX = size.width / 2;

    final offsetX = (random.nextDouble() - 0.5) * 5;

    final tapePath = Path()
      ..moveTo(centerX - tapeW / 2 + offsetX, -15)
      ..lineTo(centerX + tapeW / 2 + offsetX, -10)
      ..lineTo(centerX + tapeW / 2 + offsetX, tapeH - 10)
      ..lineTo(centerX - tapeW / 2 + offsetX, tapeH - 15)
      ..close();

    // Fill
    canvas
      ..drawPath(
        tapePath,
        Paint()
          ..color = tapeColor.withValues(alpha: 0.3)
          ..style = PaintingStyle.fill,
      )
      // Stroke
      ..drawPath(
        tapePath,
        Paint()
          ..color = tapeColor.withValues(alpha: 0.4)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0,
      );
  }

  @override
  bool shouldRepaint(covariant SketchyCardPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
