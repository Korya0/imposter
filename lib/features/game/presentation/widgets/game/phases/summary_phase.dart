import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:imposter/features/game/presentation/controller/game_session_cubit/game_session_cubit.dart';

class SummaryPhaseWidget extends StatefulWidget {
  const SummaryPhaseWidget({
    required this.secretWord,
    required this.playerCount,
    required this.spyCount,
    required this.durationMinutes,
    required this.spyIndices,
    required this.onAnotherRound,
    required this.onFinish,
    super.key,
  });

  final String secretWord;
  final int playerCount;
  final int spyCount;
  final int durationMinutes;
  final List<int> spyIndices;
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
    final session = context.read<GameSessionCubit>();
    final spyNames = widget.spyIndices
        .map((idx) => session.playerNames[idx])
        .toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: context.p(16)),
                child: Column(
                  spacing: context.p(24),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppTextWidget(
                      AppStrings.summary,
                      style: AppTextStyles.font28W700Primary,
                    ),
                    Column(
                      spacing: context.p(6),
                      children: [
                        AppTextWidget(
                          AppStrings.word,
                          style: AppTextStyles.font18W400Primary.copyWith(
                            color: AppColors.primary.withValues(alpha: 0.6),
                          ),
                        ),
                        AppTextWidget(
                          widget.secretWord,
                          style: AppTextStyles.fontSecond50W700Primary,
                        ),
                      ],
                    ),
                    _CompactStatsRow(
                      players: widget.playerCount,
                      minutes: widget.durationMinutes,
                    ),
                    _SpiesListWidget(spyNames: spyNames),
                    _AnotherRoundButton(
                      controller: _redoController,
                      onTap: widget.onAnotherRound,
                    ),
                    AppButton(
                      title: AppStrings.finishGame,
                      onTap: widget.onFinish,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CompactStatsRow extends StatelessWidget {
  const _CompactStatsRow({
    required this.players,
    required this.minutes,
  });

  final int players;
  final int minutes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: context.p(32),
      children: [
        Row(
          spacing: context.p(8),
          children: [
            SvgPicture.asset(
              AppAssets.peopleGroupSvg,
              width: context.s(22),
              height: context.s(22),
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            AppTextWidget('$players', style: AppTextStyles.font20W400White),
          ],
        ),
        Row(
          spacing: context.p(8),
          children: [
            SvgPicture.asset(
              AppAssets.timeOclockSvg,
              width: context.s(22),
              height: context.s(22),
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            AppTextWidget('$minutes:00', style: AppTextStyles.font20W400White),
          ],
        ),
      ],
    );
  }
}

class _SpiesListWidget extends StatelessWidget {
  const _SpiesListWidget({required this.spyNames});
  final List<String> spyNames;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: context.p(12),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: context.p(8),
          children: [
            SvgPicture.asset(
              AppAssets.spySvg,
              width: context.s(22),
              height: context.s(22),
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            AppTextWidget(
              AppStrings.numberOfSpies,
              style: AppTextStyles.font18W700Primary,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.p(24)),
          child: Wrap(
            spacing: context.p(10),
            runSpacing: context.p(10),
            alignment: WrapAlignment.center,
            children: spyNames
                .map(
                  (name) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.p(16),
                      vertical: context.p(8),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryBackground.withValues(
                        alpha: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(context.p(16)),
                      border: Border.all(color: AppColors.primary, width: 1.5),
                    ),
                    child: AppTextWidget(
                      name,
                      style: AppTextStyles.font16W700Primary,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
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
          padding: EdgeInsets.all(context.p(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: context.p(12),
            children: [
              CustomPaint(
                painter: const SketchyCirclePainter(color: AppColors.white),
                child: Padding(
                  padding: EdgeInsets.all(context.p(8)),
                  child: SvgPicture.asset(
                    AppAssets.redoSvg,
                    width: context.s(24),
                    height: context.s(24),
                    colorFilter: const ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              AppTextWidget(
                AppStrings.anotherRound,
                style: AppTextStyles.font20W400White,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
