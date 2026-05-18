import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class StartButton extends StatefulWidget {
  const StartButton({
    required this.onTap,
    this.isSketchy = true,
    super.key,
  });
  final VoidCallback onTap;
  final bool isSketchy;

  @override
  State<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    Widget buttonChild;

    if (widget.isSketchy) {
      const activeColor = AppColors.primary;
      buttonChild = GestureDetector(
        onTapDown: (_) {
          setState(() {
            _isPressed = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            _isPressed = false;
          });
        },
        onTapCancel: () {
          setState(() {
            _isPressed = false;
          });
        },
        onTap: () {
          HapticFeedback.lightImpact();
          widget.onTap();
        },
        behavior: HitTestBehavior.opaque,
        child: AnimatedScale(
          scale: _isPressed ? 0.95 : 1.0,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutCubic,
          child: SizedBox(
            width: 250,
            height: (context.height * 0.09).clamp(50, 64),
            child: CustomPaint(
              painter: SketchyButtonPainter(
                color: activeColor,
                isPressed: _isPressed,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextWidget(
                      AppStrings.start,
                      style: AppTextStyles.font36W700Primary,
                    ),
                    const SizedBox(width: 12),
                    SvgPicture.asset(
                      AppAssets.playSvg,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        activeColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      buttonChild = AppButton(
        width: 250,
        height: (context.height * 0.1).clamp(50, 70),
        onTap: widget.onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextWidget(
              AppStrings.start,
              style: AppTextStyles.font45W700Background,
            ),
            const SizedBox(width: 12),
            SvgPicture.asset(
              AppAssets.playSvg,
              height: (context.height * 0.04).clamp(28, 30),
            ),
          ],
        ),
      );
    }

    return buttonChild
        .animate()
        .fadeIn(delay: 600.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0);
  }
}

class SketchyButtonPainter extends CustomPainter {
  SketchyButtonPainter({required this.color, required this.isPressed});
  final Color color;
  final bool isPressed;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;

    // Draw primary wobbly sketchy border path
    final path1 = Path();
    _drawWobblyRect(path1, size, offset: 0);
    canvas.drawPath(path1, paint);

    // Draw secondary lighter sketch line slightly offset for a hand-drawn dual stroke effect
    final path2 = Path();
    _drawWobblyRect(path2, size, offset: 1.5);
    canvas.drawPath(
      path2,
      paint
        ..strokeWidth = 1.2
        ..color = color.withValues(alpha: 0.7),
    );

    // Draw organic diagonal pencil scribbles as background texture
    if (!isPressed) {
      final scribblePaint = Paint()
        ..color = color.withValues(alpha: 0.15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..strokeCap = StrokeCap.round;

      final scribblePath = Path();
      final step = size.width / 8;
      for (var i = 1; i < 8; i++) {
        final startX = i * step;
        final endX = startX + 15;
        scribblePath
          ..moveTo(startX, 6)
          ..lineTo(endX, size.height - 6);
      }
      canvas.drawPath(scribblePath, scribblePaint);
    }
  }

  void _drawWobblyRect(Path path, Size size, {required double offset}) {
    path
      ..moveTo(3 + offset, 2.5 + offset)
      ..lineTo(size.width - 2.5 - offset, 3 + offset)
      ..lineTo(size.width - 3 - offset, size.height - 2.5 - offset)
      ..lineTo(2.5 + offset, size.height - 3 - offset)
      ..close();
  }

  @override
  bool shouldRepaint(covariant SketchyButtonPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.isPressed != isPressed;
}
