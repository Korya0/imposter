import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/painters/sketchy_circle_painter.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/audio_player_helper.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

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
            spacing: context.p(24),
            mainAxisAlignment: .spaceEvenly,
            children: [
              Column(
                spacing: context.p(24),
                children: [
                  AppTextWidget(
                    AppStrings.summary,
                    style: AppTextStyles.font34W700Primary,
                  ),
                  Column(
                    spacing: context.p(4),
                    children: [
                      _SummaryInfoRow(
                        label: AppStrings.word,
                        value: widget.secretWord,
                      ),
                      _SummaryInfoRow(
                        label: AppStrings.numberOfPlayers,
                        value: widget.playerCount.toString(),
                      ),
                      _SummaryInfoRow(
                        label: AppStrings.numberOfSpies,
                        value: widget.spyCount.toString(),
                      ),
                      _SummaryInfoRow(
                        label: AppStrings.numberOfMinutes,
                        value: '${widget.durationMinutes}:00',
                      ),
                    ],
                  ),
                  _AnotherRoundButton(
                    controller: _redoController,
                    onTap: widget.onAnotherRound,
                  ),
                ],
              ),
              AppButton(
                width: double.infinity.clamp(150, 300),
                height: (context.height * 0.1).clamp(50.0, 70.0),
                title: AppStrings.finishGame,
                onTap: widget.onFinish,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryInfoRow extends StatelessWidget {
  const _SummaryInfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.p(24)),
      child: Row(
        spacing: context.p(16),
        mainAxisAlignment: .center,
        children: [
          AppTextWidget('$label:', style: AppTextStyles.font28W700Primary),
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

class _AnotherRoundButton extends StatelessWidget {
  const _AnotherRoundButton({
    required this.controller,
    required this.onTap,
  });
  final AnimationController controller;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => controller.forward(),
      onTapUp: (_) {
        controller.reverse();
        onTap();
      },
      onTapCancel: controller.reverse,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) => Transform.scale(
          scale: 1.0 - (controller.value * 0.05),
          child: child,
        ),
        child: Padding(
          padding: EdgeInsets.all(context.p(16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: context.p(16),
            children: [
              CustomPaint(
                painter: const SketchyCirclePainter(color: AppColors.white),
                child: Padding(
                  padding: EdgeInsets.all(context.p(12)),
                  child: SvgPicture.asset(
                    AppAssets.redoSvg,
                    width: context.s(32),
                    height: context.s(32),
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
    );
  }
}
