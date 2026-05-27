import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/presentation/widgets/app_loading_indicator.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/features/game/presentation/controller/game_session_cubit/game_session_cubit.dart';
import 'package:imposter/features/game/presentation/controller/game_session_cubit/game_session_state.dart';
import 'package:imposter/features/game/presentation/widgets/game/phases/revealing_phase.dart';
import 'package:imposter/features/game/presentation/widgets/game/phases/scanning_phase.dart';
import 'package:imposter/features/game/presentation/widgets/game/phases/summary_phase.dart';
import 'package:imposter/features/game/presentation/widgets/game/phases/timer_phase.dart';
import 'package:imposter/features/game/presentation/widgets/game/phases/voting_phase.dart';

class GameViewContent extends StatelessWidget {
  const GameViewContent({required this.state, super.key});
  final GameSessionState state;

  @override
  Widget build(BuildContext context) {
    final stateKey = switch (state) {
      GameSessionScanning(currentPlayerIndex: final index) => 'scanning_$index',
      GameSessionRevealing(currentPlayerIndex: final index) =>
        'revealing_$index',
      _ => state.runtimeType,
    };

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Container(
        key: ValueKey(stateKey),
        child: switch (state) {
          GameSessionInitial() => const Center(
            child: AppLoadingIndicator(),
          ),
          GameSessionScanning(currentPlayerIndex: final index) =>
            ScanningPhaseWidget(
              playerName: context.read<GameSessionCubit>().playerNames[index],
              onScanTap: () =>
                  context.read<GameSessionCubit>().toggleReveal(reveal: true),
            ),
          GameSessionRevealing(
            isSpy: final spy,
            secretWord: final word,
          ) =>
            RevealingPhaseWidget(
              isSpy: spy,
              secretWord: word,

              onNext: () =>
                  context.read<GameSessionCubit>().toggleReveal(reveal: false),
            ),
          GameSessionTimer(durationMinutes: final mins) => TimerPhaseWidget(
            durationMinutes: mins,
            onTimeout: context.read<GameSessionCubit>().startVoting,
            onFinishTurn: context.read<GameSessionCubit>().startVoting,
          ),
          GameSessionVoting() => VotingPhaseWidget(
            onFinishVoting: (votes) =>
                context.read<GameSessionCubit>().finishGame(votes),
          ),
          GameSessionSummary(
            secretWord: final word,
            spyIndices: final spies,
            votedSpies: final votes,
          ) =>
            SummaryPhaseWidget(
              secretWord: word,
              spyIndices: spies,
              votedSpies: votes,
              onAnotherRound: context
                  .read<GameSessionCubit>()
                  .prepareAnotherRound,
              onFinish: () {
                context.read<GameSessionCubit>().reset();
                context.goNamed(AppRoutes.home);
              },
            ),
        },
      ),
    );
  }
}
