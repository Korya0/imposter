import 'dart:math';

import 'package:flutter/material.dart';

class TornPaperPainter extends CustomPainter {
  TornPaperPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final random = Random(42);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 20);

    // Jagged TOP
    var curX = size.width;
    while (curX > 0) {
      final step = 10.0 + random.nextDouble() * 10.0;
      final dy = random.nextDouble() * 20.0;
      curX -= step;
      if (curX < 0) curX = 0;
      path.lineTo(curX, dy);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
