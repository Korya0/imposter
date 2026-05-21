import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_loading_indicator.dart';
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
  const GameViewContent({required this.state, super.key});
  final GameState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Container(
            key: ValueKey(state.runtimeType),
            child: _GameStateContent(state: state),
          ),
        ),
        _GameBottomAction(state: state),
      ],
    );
  }
}

class _GameStateContent extends StatelessWidget {
  const _GameStateContent({required this.state});
  final GameState state;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      GameInitial() || GameLoading() => const Center(
        child: AppLoadingIndicator(),
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
        selectedCategory: final cat,
      ) =>
        RevealingPhaseWidget(
          isSpy: spy,
          secretWord: word,
          categoryName: cat!.name,
        ),
      GameReady() => ReadyPhaseWidget(
        onStartTimer: context.read<GameCubit>().startTimer,
      ),
      GameTimer(durationMinutes: final mins) => TimerPhaseWidget(
        durationMinutes: mins,
        onTimeout: context.read<GameCubit>().finishGame,
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
          onAnotherRound: context.read<GameCubit>().prepareRound,
          onFinish: () => context.goNamed(AppRoutes.home),
        ),
      GameError(message: final msg) => Center(child: AppTextWidget(msg)),
    };
  }
}

class _GameBottomAction extends StatelessWidget {
  const _GameBottomAction({required this.state});
  final GameState state;

  @override
  Widget build(BuildContext context) {
    final buttonHeight = (context.height * 0.1).clamp(50.0, 70.0);

    final actionButton = switch (state) {
      GameScanning() => GameFingerprintButton(
        onTap: () => context.read<GameCubit>().toggleReveal(reveal: true),
      ),
      GameRevealing() => _FullWidthButton(
        height: buttonHeight,
        title: AppStrings.next,
        onTap: () => context.read<GameCubit>().toggleReveal(reveal: false),
      ),
      GameTimer() => _FullWidthButton(
        height: buttonHeight,
        title: AppStrings.finishTurn,
        onTap: context.read<GameCubit>().finishGame,
      ),
      GameSummary() => _FullWidthButton(
        height: buttonHeight,
        title: AppStrings.finishGame,
        onTap: () => context.goNamed(AppRoutes.home),
      ),
      _ => null,
    };

    if (actionButton == null) return const SizedBox.shrink();

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(bottom: context.p(24)),
        child: actionButton,
      ),
    );
  }
}

class _FullWidthButton extends StatelessWidget {
  const _FullWidthButton({
    required this.height,
    required this.title,
    required this.onTap,
  });
  final double height;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.p(24)),
      child: AppButton(
        width: double.infinity.clamp(150, 300),
        height: height,
        title: title,
        onTap: onTap,
      ),
    );
  }
}
