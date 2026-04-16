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
    return Padding(
      padding: EdgeInsets.only(
        bottom: (context.height * 0.05).clamp(12, 32),
      ),
      child: Column(
        children: [
          const CustomAppBar(),
          Expanded(
            child: _buildCurrentStateWidget(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStateWidget(BuildContext context) {
    Widget child;
    switch (currentState) {
      case GameViewState.scanning:
        child = ScanViewBody(onScanComplete: onScanComplete);
      case GameViewState.revealSpy:
        child = SpyRevealView(onNext: onNext);
      case GameViewState.revealCitizen:
        child = CitizenRevealView(onNext: onNext);
      case GameViewState.ready:
        child = GameReadyView(onStartTimer: onStartTimer);
      case GameViewState.timer:
        child = Center(
          child: LottieTimer(
            duration: const Duration(seconds: 10),
            onTimeout: onFinishGame,
            onFinish: onFinishGame,
          ),
        );
      case GameViewState.summary:
        child = GameSummaryView(
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
        .slideX(begin: 0.1, end: 0, curve: Curves.easeOutQuad);
  }
}
