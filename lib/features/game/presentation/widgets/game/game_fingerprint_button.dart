import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/haptic_feedback_helper.dart';

class GameFingerprintButton extends StatefulWidget {
  const GameFingerprintButton({required this.onTap, super.key});
  final VoidCallback onTap;

  @override
  State<GameFingerprintButton> createState() => _GameFingerprintButtonState();
}

class _GameFingerprintButtonState extends State<GameFingerprintButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  bool _isPressed = false;
  bool _completed = false;
  int _lastTick = -1;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )
      ..addListener(() {
        setState(() {});
        // Rhythmic tactile ticking feedback
        final currentTick = (_progressController.value * 10).floor();
        if (currentTick > _lastTick) {
          _lastTick = currentTick;
          HapticFeedbackHelper.selection();
        }
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _onScanComplete();
        }
      });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  Future<void> _onScanComplete() async {
    setState(() {
      _completed = true;
    });
    await HapticFeedbackHelper.successPattern();
    if (mounted) {
      widget.onTap();
      // Reset state for next player scan
      setState(() {
        _completed = false;
        _isPressed = false;
        _lastTick = -1;
        _progressController.reset();
      });
    }
  }

  void _onPressStart() {
    if (!_completed) {
      _progressController.forward();
      setState(() {
        _isPressed = true;
      });
    }
  }

  void _onPressEnd() {
    if (!_completed) {
      _progressController.reverse();
      setState(() {
        _isPressed = false;
        _lastTick = -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scanColor = _completed
        ? AppColors.green
        : (_isPressed ? AppColors.primary : AppColors.primary.withValues(alpha: 0.8));

    return GestureDetector(
      onTapDown: (_) => _onPressStart(),
      onTapUp: (_) => _onPressEnd(),
      onTapCancel: _onPressEnd,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 24,
        children: [
          AppTextWidget(
            _completed
                ? 'تم البصم بنجاح' // Scan completed successfully!
                : (_isPressed ? 'خليك باصم...' : AppStrings.scanHere), // Keep holding... or Scan Here
            style: AppTextStyles.font36W700Primary,
          ),
          RepaintBoundary(
            child: CustomPaint(
              painter: ScannerProgressPainter(
                progress: _progressController.value,
                color: AppColors.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  AppAssets.fingerprintSvg,
                  height: 120,
                  colorFilter: ColorFilter.mode(
                    scanColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          )
              .animate(target: _isPressed ? 1 : 0)
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.15, 1.15),
                duration: 150.ms,
              ),
        ],
      ),
    );
  }
}

class ScannerProgressPainter extends CustomPainter {
  final double progress;
  final Color color;

  ScannerProgressPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) + 2; // Draw just outside the SVG fingerprint

    final rect = Rect.fromCircle(center: center, radius: radius);
    const startAngle = -3.14159 / 2; // top center
    final sweepAngle = 2 * 3.14159 * progress;

    // Draw the main progress arc
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

    // Draw a sketchy offset accent line just 3px further out
    final outerPaint = Paint()
      ..color = color.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final outerRect = Rect.fromCircle(center: center, radius: radius + 3);
    canvas.drawArc(outerRect, startAngle + 0.1, sweepAngle * 0.95, false, outerPaint);
  }

  @override
  bool shouldRepaint(covariant ScannerProgressPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
