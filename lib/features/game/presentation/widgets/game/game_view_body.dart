import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/widgets/custom_app_bar.dart';
import 'package:imposter/features/game/presentation/models/game_view_state.dart';
import 'package:imposter/features/game/presentation/widgets/game/citizen_reveal_view.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_ready_view.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_summary_view.dart';
import 'package:imposter/features/game/presentation/widgets/game/lottie_timer.dart';
import 'package:imposter/features/game/presentation/widgets/game/scan_view_body.dart';
import 'package:imposter/features/game/presentation/widgets/game/spy_reveal_view.dart';

import 'package:imposter/features/game/presentation/widgets/game/game_fingerprint_button.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_finish_game_button.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_finish_turn_button.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_next_button.dart';

class GameViewBody extends StatelessWidget {
  final GameViewState currentState;
  final VoidCallback onScanComplete;
  final VoidCallback onNext;
  final VoidCallback onStartTimer;
  final VoidCallback onFinishGame;
  final VoidCallback onAnotherRound;

  const GameViewBody({
    super.key,
    required this.currentState,
    required this.onScanComplete,
    required this.onNext,
    required this.onStartTimer,
    required this.onFinishGame,
    required this.onAnotherRound,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(),
        Expanded(
          child: _buildCurrentStateContent(context),
        ),
        _buildBottomAction(context),
        SizedBox(height: (context.height * 0.05).clamp(12, 32)),
      ],
    );
  }

  Widget _buildCurrentStateContent(BuildContext context) {
    Widget child;
    switch (currentState) {
      case GameViewState.scanning:
        return const ScanViewBody();
      case GameViewState.revealSpy:
        child = const SpyRevealView();
      case GameViewState.revealCitizen:
        child = const CitizenRevealView();
      case GameViewState.ready:
        child = GameReadyView(onStartTimer: onStartTimer);
      case GameViewState.timer:
        child = LottieTimer(
          duration: const Duration(seconds: 10), // TODO(binding): connect to cubit
          onTimeout: onFinishGame,
        );
      case GameViewState.summary:
        return GameSummaryView(
          secretWord: 'مسجد',
          playersCount: 4,
          spiesCount: 1,
          duration: const Duration(minutes: 1),
          onAnotherRound: onAnotherRound,
          onFinish: () => context.goNamed(AppRoutes.home),
        );
    }

    return child
        .animate(key: ValueKey(currentState))
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.05, end: 0, curve: Curves.easeOutQuad);
  }

  Widget _buildBottomAction(BuildContext context) {
    switch (currentState) {
      case GameViewState.scanning:
        return GameFingerprintButton(onTap: onScanComplete);
      case GameViewState.revealSpy:
      case GameViewState.revealCitizen:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: GameNextButton(onPressed: onNext),
        );
      case GameViewState.timer:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: GameFinishTurnButton(onPressed: onFinishGame),
        );
      case GameViewState.summary:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: GameFinishGameButton(
            onPressed: () => context.goNamed(AppRoutes.home),
          ),
        );
      case GameViewState.ready:
        return const SizedBox.shrink();
    }
  }
}
