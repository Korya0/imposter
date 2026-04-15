import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/widgets/custom_app_bar.dart';
import 'package:imposter/features/game/widgets/citizen_reveal_view.dart';
import 'package:imposter/features/game/widgets/game_ready_view.dart';
import 'package:imposter/features/game/widgets/scan_view_body.dart';
import 'package:imposter/features/game/widgets/spy_reveal_view.dart';

enum GameViewState { scanning, revealSpy, revealCitizen, ready }

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  GameViewState _currentState = GameViewState.scanning;
  int _currentPlayerIndex = 0;
  final int _totalPlayers = 3; // Mock value
  final int _spyIndex = 1; // Mock value

  void _onScanComplete() {
    setState(() {
      if (_currentPlayerIndex == _spyIndex) {
        _currentState = GameViewState.revealSpy;
      } else {
        _currentState = GameViewState.revealCitizen;
      }
    });
  }

  void _onNext() {
    setState(() {
      if (_currentPlayerIndex < _totalPlayers - 1) {
        _currentPlayerIndex++;
        _currentState = GameViewState.scanning;
      } else {
        _currentState = GameViewState.ready;
      }
    });
  }

  void _onStartTimer() {
    // Navigate to timer view in the future
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPaddings.h18,
          child: SingleChildScrollView(
            child: SizedBox(
              height:
                  context.height -
                  MediaQuery.paddingOf(context).top -
                  MediaQuery.paddingOf(context).bottom,
              child: _GameViewBody(
                currentState: _currentState,
                onScanComplete: _onScanComplete,
                onNext: _onNext,
                onStartTimer: _onStartTimer,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GameViewBody extends StatelessWidget {
  final GameViewState currentState;
  final VoidCallback onScanComplete;
  final VoidCallback onNext;
  final VoidCallback onStartTimer;

  const _GameViewBody({
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
