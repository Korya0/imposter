import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/painters/sketchy_circle_painter.dart';
import 'package:imposter/core/presentation/painters/sketchy_input_painter.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_divider.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/audio_player_helper.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/presentation/controller/game_session_cubit/game_session_cubit.dart';

class SummaryPhaseWidget extends StatefulWidget {
  const SummaryPhaseWidget({
    required this.secretWord,
    required this.spyIndices,
    required this.votedSpies,
    required this.onAnotherRound,
    required this.onFinish,
    super.key,
  });

  final String secretWord;
  final List<int> spyIndices;
  final Map<int, List<int>> votedSpies;
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
    final sortedIndices = List<int>.from(widget.spyIndices)..sort();
    final spyNames = sortedIndices
        .map((idx) => session.playerNames[idx])
        .toList();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Column(
            children: [
              // Header & Title
              Column(
                children: [
                  AppTextWidget(
                    AppStrings.summary,
                    style: AppTextStyles.font28W700Primary,
                  ),
                  const AppDivider(),
                ],
              ),

              // Centered Word Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  AppTextWidget(
                    '${AppStrings.word}: ',
                    style: AppTextStyles.font24W700Primary,
                  ),
                  AppTextWidget(
                    widget.secretWord,
                    style: AppTextStyles.font30W700Primary,
                  ),
                ],
              ),

              // Spies Section
              _SpiesListWidget(spyNames: spyNames),

              // Results Section
              _VotingResultsWidget(
                spyIndices: widget.spyIndices,
                votedSpies: widget.votedSpies,
                playerNames: session.playerNames,
              ),
            ],
          ),
          // Redo & Finish game buttons
          Column(
            spacing: context.p(24),
            children: [
              const AppDivider(),

              // Redo
              _AnotherRoundButton(
                controller: _redoController,
                onTap: widget.onAnotherRound,
              ),

              // finish game button
              AppButton(
                title: AppStrings.finishGame,
                onTap: widget.onFinish,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SpiesListWidget extends StatelessWidget {
  const _SpiesListWidget({required this.spyNames});
  final List<String> spyNames;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: context.p(16),
      children: [
        const AppGap(24),
        AppTextWidget(
          AppStrings.numberOfSpies,
          style: AppTextStyles.font18W700Primary,
        ),
        Wrap(
          spacing: context.p(12),
          runSpacing: context.p(12),
          alignment: WrapAlignment.center,
          children: spyNames
              .map(
                (name) => CustomPaint(
                  painter: SketchyInputPainter(
                    color: AppColors.primary,
                    fillColor: AppColors.secondaryBackground.withValues(
                      alpha: 0.4,
                    ),
                    strokeWidth: 1.8,
                    isFocused: true,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.p(20),
                      vertical: context.p(10),
                    ),
                    child: AppTextWidget(
                      name,
                      style: AppTextStyles.font16W700Primary,
                    ),
                  ),
                ),
              )
              .toList(),
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
      child: ScaleTransition(
        scale: Tween<double>(begin: 1, end: 0.92).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.easeInOut,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: context.p(12),
          children: [
            CustomPaint(
              painter: const SketchyCirclePainter(color: AppColors.primary),
              child: Padding(
                padding: EdgeInsets.all(context.p(8)),
                child: SvgPicture.asset(
                  AppAssets.redoSvg,
                  width: context.s(28),
                  height: context.s(28),
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            AppTextWidget(
              AppStrings.anotherRound,
              style: AppTextStyles.font22W400Primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _VotingResultsWidget extends StatelessWidget {
  const _VotingResultsWidget({
    required this.spyIndices,
    required this.votedSpies,
    required this.playerNames,
  });

  final List<int> spyIndices;
  final Map<int, List<int>> votedSpies;
  final List<String> playerNames;

  @override
  Widget build(BuildContext context) {
    final guessedPlayers = <String>[];
    for (var i = 0; i < playerNames.length; i++) {
      if (spyIndices.contains(i)) continue;

      final voterVotes = votedSpies[i] ?? [];
      final guessedAll =
          voterVotes.length == spyIndices.length &&
          voterVotes.every(spyIndices.contains);

      if (guessedAll) {
        guessedPlayers.add(playerNames[i]);
      }
    }

    final hasWinners = guessedPlayers.isNotEmpty;

    return Column(
      spacing: context.p(16),
      children: [
        const AppGap(24),
        AppTextWidget(
          hasWinners ? AppStrings.playersWhoCaughtSpy : AppStrings.spyGotAway,
          style: AppTextStyles.font18W700Primary,
        ),
        if (hasWinners)
          Wrap(
            spacing: context.p(12),
            runSpacing: context.p(12),
            alignment: WrapAlignment.center,
            children: guessedPlayers
                .map(
                  (name) => CustomPaint(
                    painter: SketchyInputPainter(
                      color: AppColors.primary,
                      fillColor: AppColors.secondaryBackground.withValues(
                        alpha: 0.4,
                      ),
                      strokeWidth: 1.8,
                      isFocused: true,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.p(20),
                        vertical: context.p(10),
                      ),
                      child: AppTextWidget(
                        name,
                        style: AppTextStyles.font16W700Primary,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}
