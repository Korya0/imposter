import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/audio_player_helper.dart';

class SummaryPhaseWidget extends StatefulWidget {
  const SummaryPhaseWidget({
    required this.secretWord,
    required this.playerCount,
    required this.spyCount,
    required this.durationMinutes,
    required this.onAnotherRound,
    required this.onFinish,
    super.key,
  });
  final String secretWord;
  final int playerCount;
  final int spyCount;
  final int durationMinutes;
  final VoidCallback onAnotherRound;
  final VoidCallback onFinish;

  @override
  State<SummaryPhaseWidget> createState() => _SummaryPhaseWidgetState();
}

class _SummaryPhaseWidgetState extends State<SummaryPhaseWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _redoController;

  @override
  void initState() {
    super.initState();
    unawaited(AudioPlayerHelper.playWin());
    _redoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _redoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              AppTextWidget(
                AppStrings.summary,
                style: AppTextStyles.font34W700Primary,
              ),
              const SizedBox(height: 6),
              _buildInfoRow(AppStrings.word, widget.secretWord),
              const SizedBox(height: 12),
              _buildInfoRow(
                AppStrings.numberOfPlayers,
                widget.playerCount.toString(),
              ),
              const SizedBox(height: 12),
              _buildInfoRow(
                AppStrings.numberOfSpies,
                widget.spyCount.toString(),
              ),
              const SizedBox(height: 12),
              _buildInfoRow(
                AppStrings.numberOfMinutes,
                '${widget.durationMinutes}:00',
              ),
              const SizedBox(height: 40),
              Center(
                child: GestureDetector(
                  onTapDown: (_) => _redoController.forward(),
                  onTapUp: (_) {
                    _redoController.reverse();
                    widget.onAnotherRound();
                  },
                  onTapCancel: () => _redoController.reverse(),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedBuilder(
                    animation: _redoController,
                    builder: (context, child) {
                      final scale = 1.0 - (_redoController.value * 0.05);
                      return Transform.scale(
                        scale: scale,
                        child: child,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(context.p(16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 16,
                        children: [
                          CustomPaint(
                            painter: SketchyCirclePainter(color: AppColors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: SvgPicture.asset(
                                AppAssets.redoSvg,
                                width: 32,
                                height: 32,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                          AppTextWidget(
                            AppStrings.anotherRound,
                            style: AppTextStyles.font28W400White,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.p(24)),
      child: Row(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTextWidget(
            '$label:',
            style: AppTextStyles.font28W700Primary,
          ),

          AppTextWidget(
            value,
            style: AppTextStyles.font28W700Primary.copyWith(
              color: AppColors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
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
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    final rect = Rect.fromCircle(center: center, radius: radius);

    // Primary sketched loop
    canvas.drawArc(rect, 0, 6.28, false, paint);

    // Secondary offset sketch shadow loop
    final outerRect = Rect.fromCircle(center: center, radius: radius + 3);
    final shadowPaint = Paint()
      ..color = color.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawArc(outerRect, 0.45, 5.8, false, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
