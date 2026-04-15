import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/presentation/models/game_view_state.dart';
import 'package:imposter/features/game/presentation/widgets/game_view_body.dart';

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
              child: GameViewBody(
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
