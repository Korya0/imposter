import 'dart:math';

import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class AppSketchyCard extends StatelessWidget {
  const AppSketchyCard({
    required this.title,
    super.key,
    this.watermark,
    this.showTape = true,
    this.onTap,
    this.maxLines = 1,
  });

  final String title;
  final Widget? watermark;
  final bool showTape;
  final VoidCallback? onTap;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          minHeight: context.h(150),
          minWidth: context.w(250),
        ),

        child: RepaintBoundary(
          child: CustomPaint(
            painter: _SketchyCardPainter(
              color: AppColors.primary,
              showTape: showTape,
            ),
            child: Container(
              padding: EdgeInsets.all(context.p(4)),
              alignment: Alignment.center,
              child: _CardInnerContent(
                title: title,
                watermark: watermark,
                maxLines: maxLines,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardInnerContent extends StatelessWidget {
  final String title;
  final Widget? watermark;
  final int maxLines;

  const _CardInnerContent({
    required this.title,
    required this.watermark,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (watermark != null)
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              AppColors.primary.withValues(alpha: 0.1),
              BlendMode.srcIn,
            ),
            child: watermark,
          ),
        AppTextWidget(
          title,
          textAlign: TextAlign.center,
          maxLines: maxLines,
          style: AppTextStyles.font28W700Primary,
        ),
      ],
    );
  }
}

class _SketchyCardPainter extends CustomPainter {
  _SketchyCardPainter({
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
  bool shouldRepaint(covariant _SketchyCardPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.showTape != showTape;
}
