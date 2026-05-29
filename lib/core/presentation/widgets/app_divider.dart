import 'dart:math';

import 'package:flutter/material.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.p(12)),
      child: SizedBox(
        width: double.infinity,
        height: context.h(4),
        child: const CustomPaint(
          painter: _SketchyHorizontalLinePainter(
            color: AppColors.secondaryBackground,
          ),
        ),
      ),
    );
  }
}

class _SketchyHorizontalLinePainter extends CustomPainter {
  const _SketchyHorizontalLinePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final random = Random(42);

    path.moveTo(0, size.height / 2);

    double x = 0;
    while (x < size.width) {
      x += 10 + random.nextDouble() * 15;
      if (x > size.width) x = size.width;

      final y = (size.height / 2) + (random.nextDouble() * 2 - 1);
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SketchyHorizontalLinePainter oldDelegate) =>
      oldDelegate.color != color;
}
