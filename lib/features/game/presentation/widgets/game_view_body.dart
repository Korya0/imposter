import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/widgets/custom_app_bar.dart';
import 'package:imposter/features/game/presentation/models/game_view_state.dart';
import 'package:imposter/features/game/presentation/widgets/citizen_reveal_view.dart';
import 'package:imposter/features/game/presentation/widgets/game_ready_view.dart';
import 'package:imposter/features/game/presentation/widgets/scan_view_body.dart';
import 'package:imposter/features/game/presentation/widgets/spy_reveal_view.dart';

class GameViewBody extends StatelessWidget {
  final GameViewState currentState;
  final VoidCallback onScanComplete;
  final VoidCallback onNext;
  final VoidCallback onStartTimer;

  const GameViewBody({
    super.key,
    required this.currentState,
    required this.onScanComplete,
    required this.onNext,
    required this.onStartTimer,
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
            child: _buildCurrentStateWidget(),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStateWidget() {
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
    }

    return child
        .animate(key: ValueKey(currentState))
        .fadeIn(duration: 400.ms)
        .slideX(begin: 0.1, end: 0, curve: Curves.easeOutQuad);
  }
}
