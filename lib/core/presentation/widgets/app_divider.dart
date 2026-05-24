
import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/painters/sketchy_horizontal_line_painter.dart';
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
          painter: SketchyHorizontalLinePainter(
            color: AppColors.secondaryBackground,
          ),
        ),
      ),
    );
  }
}
