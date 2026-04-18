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

  late final Paint _outerCirclePaint;
  late final Paint _innerCirclePaint;
  late final Paint _markerPaint;
  late final Paint _minuteHandPaint;
  late final Paint _secondHandPaint;
  late final Paint _centerDotPrimaryPaint;
  late final Paint _centerDotSecondaryPaint;

  _ClockPainter({
    required this.value,
    required this.primaryColor,
    required this.secondaryColor,
  }) {
    _outerCirclePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    _innerCirclePaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    _markerPaint = Paint()
      ..color = primaryColor
      ..strokeWidth = 2;

    _minuteHandPaint = Paint()
      ..color = secondaryColor
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    _secondHandPaint = Paint()
      ..color = primaryColor
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    _centerDotPrimaryPaint = Paint()..color = primaryColor;
    _centerDotSecondaryPaint = Paint()..color = secondaryColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    canvas
      ..drawCircle(center, radius, _outerCirclePaint)
      ..drawCircle(center, radius, _innerCirclePaint);

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
      canvas.drawLine(start, end, _markerPaint);
    }

    final minuteAngle = (value * 360 - 90) * pi / 180;
    canvas.drawLine(
      center,
      Offset(
        center.dx + (radius * 0.6) * cos(minuteAngle),
        center.dy + (radius * 0.6) * sin(minuteAngle),
      ),
      _minuteHandPaint,
    );

    final secondAngle = (value * 360 * 60 - 90) * pi / 180;
    canvas
      ..drawLine(
        center,
        Offset(
          center.dx + (radius * 0.8) * cos(secondAngle),
          center.dy + (radius * 0.8) * sin(secondAngle),
        ),
        _secondHandPaint,
      )
      ..drawCircle(center, 6, _centerDotPrimaryPaint)
      ..drawCircle(center, 3, _centerDotSecondaryPaint);
  }

  @override
  bool shouldRepaint(covariant _ClockPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
