import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';

class ReadyPhaseWidget extends StatelessWidget {
  const ReadyPhaseWidget({
    required this.onStartTimer,
    super.key,
  });
  final VoidCallback onStartTimer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onStartTimer,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: Column(
          spacing: context.p(30),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextWidget(
              AppStrings.ready,
              style: AppTextStyles.font45W700Primary,
            ),
            CustomPaint(
              painter: SketchyCirclePainter(color: AppColors.primary),
              child: Padding(
                padding: EdgeInsets.all(context.p(24)),
                child: SvgPicture.asset(
                  AppAssets.playSvg,
                  height: 60,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ).animate().fadeIn().scale(),
    );
  }
}

class SketchyCirclePainter extends CustomPainter {
  final Color color;

  SketchyCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    final rect = Rect.fromCircle(center: center, radius: radius);

    // Draw sketchy primary loop
    canvas.drawArc(rect, 0, 6.28, false, paint);

    // Draw sketchy secondary offset loop for double-drawn cardboard feel
    final outerRect = Rect.fromCircle(center: center, radius: radius + 3);
    final shadowPaint = Paint()
      ..color = color.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(outerRect, 0.45, 5.8, false, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
