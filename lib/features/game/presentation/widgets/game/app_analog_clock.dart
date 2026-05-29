import 'dart:math';

import 'package:flutter/material.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class AppAnalogClock extends StatelessWidget {
  const AppAnalogClock({
    required this.value,
    super.key,
    this.size,
  });
  final double value;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final clockSize = size ?? context.s(200);
    return SizedBox(
      width: clockSize,
      height: clockSize,
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

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    canvas
      ..drawCircle(center, radius, _outerCirclePaint)
      ..drawCircle(center, radius, _innerCirclePaint);

    final markerLength = radius * 0.1;
    for (var i = 0; i < 12; i++) {
      final angle = (i * 30) * pi / 180;
      final start = Offset(
        center.dx + (radius - markerLength) * cos(angle),
        center.dy + (radius - markerLength) * sin(angle),
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
      ..drawCircle(center, radius * 0.06, _centerDotPrimaryPaint)
      ..drawCircle(center, radius * 0.03, _centerDotSecondaryPaint);
  }

  @override
  bool shouldRepaint(covariant _ClockPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
