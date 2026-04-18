import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';
import 'package:imposter/features/game/presentation/cubit/game_state.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_fingerprint_button.dart';
import 'package:imposter/features/game/presentation/widgets/game/phases/ready_phase.dart';
import 'package:imposter/features/game/presentation/widgets/game/phases/revealing_phase.dart';
import 'package:imposter/features/game/presentation/widgets/game/phases/scanning_phase.dart';
import 'package:imposter/features/game/presentation/widgets/game/phases/summary_phase.dart';
import 'package:imposter/features/game/presentation/widgets/game/phases/timer_phase.dart';

class GameViewContent extends StatelessWidget {
  final GameState state;

  const GameViewContent({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _buildCurrentStateContent(context),
        ),
        _buildBottomAction(context),
      ],
    );
  }

  Widget _buildCurrentStateContent(BuildContext context) {
    final cubit = context.read<GameCubit>();

    return switch (state) {
      GameInitial() || GameLoading() => const Center(
          child: CircularProgressIndicator(),
        ),
      GameCategoriesLoaded() => const Center(
          child: AppTextWidget(AppStrings.comingSoon),
        ),
      GameScanning(currentPlayerIndex: final index) => ScanningPhaseWidget(
          playerNumber: index + 1,
        ),
      GameRevealing(
        isSpy: final spy,
        secretWord: final word,
        selectedCategory: final cat
      ) =>
        RevealingPhaseWidget(
          isSpy: spy,
          secretWord: word,
          categoryName: cat!.name,
        ),
      GameReady() => ReadyPhaseWidget(
          onStartTimer: cubit.startTimer,
        ),
      GameTimer(durationMinutes: final mins) => TimerPhaseWidget(
          durationMinutes: mins,
          onTimeout: cubit.finishGame,
        ),
      GameSummary(
        secretWord: final word,
        playerCount: final p,
        spyCount: final s,
        durationMinutes: final d,
      ) =>
        SummaryPhaseWidget(
          secretWord: word,
          playerCount: p,
          spyCount: s,
          durationMinutes: d,
          onAnotherRound: cubit.prepareRound,
          onFinish: () => context.goNamed(AppRoutes.home),
        ),
      GameError(message: final msg) => Center(
          child: AppTextWidget(msg),
        ),
    }
        .animate(key: ValueKey(state))
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.05, end: 0, curve: Curves.easeOutQuad);
  }

  Widget _buildBottomAction(BuildContext context) {
    final cubit = context.read<GameCubit>();

    return switch (state) {
      GameScanning() => GameFingerprintButton(
          onTap: () => cubit.toggleReveal(true),
        ),
      GameRevealing() => Padding(
          padding: AppPaddings.h24,
          child: AppButton(
            width: double.infinity,
            height: (context.height * 0.1).clamp(50, 70),
            title: AppStrings.next,
            onTap: () => cubit.toggleReveal(false),
          ),
        ),
      GameTimer() => Padding(
          padding: AppPaddings.h24,
          child: AppButton(
            width: double.infinity,
            height: (context.height * 0.1).clamp(50, 70),
            title: AppStrings.finishTurn,
            onTap: cubit.finishGame,
          ),
        ),
      GameSummary() => Padding(
          padding: AppPaddings.h24,
          child: AppButton(
            width: double.infinity,
            height: (context.height * 0.1).clamp(50, 70),
            title: AppStrings.finishGame,
            onTap: () => context.goNamed(AppRoutes.home),
          ),
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
