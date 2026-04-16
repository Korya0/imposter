import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/widgets/custom_app_bar.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';
import 'package:imposter/features/game/presentation/cubit/game_state.dart';
import 'package:imposter/features/game/presentation/widgets/game/citizen_reveal_view.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_fingerprint_button.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_finish_game_button.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_finish_turn_button.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_next_button.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_ready_view.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_summary_view.dart';
import 'package:imposter/features/game/presentation/widgets/game/lottie_timer.dart';
import 'package:imposter/features/game/presentation/widgets/game/scan_view_body.dart';
import 'package:imposter/features/game/presentation/widgets/game/spy_reveal_view.dart';

class GameViewBody extends StatelessWidget {
  final GameState currentState;

  const GameViewBody({
    super.key,
    required this.currentState,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: AppPaddings.h18,
        child: Column(
          children: [
            const CustomAppBar(),
            Expanded(
              child: _buildCurrentStateContent(context),
            ),
            _buildBottomAction(context),
            SizedBox(height: (context.height * 0.05).clamp(12, 32)),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStateContent(BuildContext context) {
    final cubit = context.read<GameCubit>();

    return switch (currentState) {
          GameInitial() ||
          GameLoading() => const Center(child: CircularProgressIndicator()),
          GameCategoriesLoaded() => const Center(
            child: Text('Category Selection Soon'),
          ),
          GameScanning(currentPlayerIndex: final index) => ScanViewBody(
            playerNumber: index + 1,
          ),
          GameRevealing(isSpy: final spy, secretWord: final word) =>
            spy ? const SpyRevealView() : CitizenRevealView(word: word!),
          GameReady() => GameReadyView(onStartTimer: cubit.startTimer),
          GameTimer(durationMinutes: final mins) => LottieTimer(
            duration: Duration(minutes: mins),
            onTimeout: cubit.finishGame,
          ),
          GameSummary(
            secretWord: final word,
            playerCount: final p,
            spyCount: final s,
            durationMinutes: final d,
          ) =>
            GameSummaryView(
              secretWord: word!,
              playersCount: p,
              spiesCount: s,
              duration: Duration(minutes: d),
              onAnotherRound: cubit.prepareRound,
              onFinish: () => context.goNamed(AppRoutes.home),
            ),
          GameError(message: final msg) => Center(child: Text(msg)),
        }
        .animate(key: ValueKey(currentState))
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.05, end: 0, curve: Curves.easeOutQuad);
  }

  Widget _buildBottomAction(BuildContext context) {
    final cubit = context.read<GameCubit>();

    return switch (currentState) {
      GameScanning() => GameFingerprintButton(
        onTap: () => cubit.toggleReveal(true),
      ),
      GameRevealing() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: GameNextButton(onPressed: () => cubit.toggleReveal(false)),
      ),
      GameTimer() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: GameFinishTurnButton(onPressed: cubit.finishGame),
      ),
      GameSummary() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: GameFinishGameButton(
          onPressed: () => context.goNamed(AppRoutes.home),
        ),
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
