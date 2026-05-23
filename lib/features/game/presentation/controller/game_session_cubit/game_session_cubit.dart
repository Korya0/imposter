import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/features/game/domain/entities/category_entity.dart';
import 'package:imposter/features/game/domain/services/game_engine.dart';
import 'package:imposter/features/game/presentation/controller/game_session_cubit/game_session_state.dart';

class GameSessionCubit extends Cubit<GameSessionState> {
  GameSessionCubit(this._gameEngine) : super(const GameSessionInitial());
  final GameEngine _gameEngine;

  int _playerCount = 3;
  int _spyCount = 1;
  int _durationMinutes = 2;
  CategoryEntity? _category;
  final List<String> _playedWordIds = [];

  void startGame({
    required int playerCount,
    required int spyCount,
    required int durationMinutes,
    required CategoryEntity category,
  }) {
    if (_category?.id != category.id) {
      _playedWordIds.clear();
    }

    _playerCount = playerCount;
    _spyCount = spyCount;
    _durationMinutes = durationMinutes;
    _category = category;

    final setup = _gameEngine.prepareRound(
      category: category,
      playerCount: playerCount,
      spyCount: spyCount,
      playedWordIds: _playedWordIds,
    );

    _playedWordIds.add(setup.secretWord.id);

    emit(
      GameSessionScanning(
        currentPlayerIndex: 0,
        secretWord: setup.secretWord.name,
        spyIndices: setup.spyIndices,
      ),
    );
  }

  void toggleReveal({required bool reveal}) {
    final currentState = state;
    if (reveal && currentState is GameSessionScanning) {
      emit(
        GameSessionRevealing(
          currentPlayerIndex: currentState.currentPlayerIndex,
          secretWord: currentState.secretWord,
          spyIndices: currentState.spyIndices,
          isSpy: currentState.spyIndices.contains(
            currentState.currentPlayerIndex,
          ),
        ),
      );
    } else if (!reveal && currentState is GameSessionRevealing) {
      nextPlayer();
    }
  }

  void nextPlayer() {
    final currentState = state;
    var index = 0;
    var word = '';
    var spies = <int>[];

    if (currentState is GameSessionScanning) {
      index = currentState.currentPlayerIndex;
      word = currentState.secretWord;
      spies = currentState.spyIndices;
    } else if (currentState is GameSessionRevealing) {
      index = currentState.currentPlayerIndex;
      word = currentState.secretWord;
      spies = currentState.spyIndices;
    } else {
      return;
    }

    final nextIndex = index + 1;

    if (nextIndex < _playerCount) {
      emit(
        GameSessionScanning(
          currentPlayerIndex: nextIndex,
          secretWord: word,
          spyIndices: spies,
        ),
      );
    } else {
      emit(
        GameSessionReady(
          secretWord: word,
          spyIndices: spies,
        ),
      );
    }
  }

  void startTimer() {
    final currentState = state;
    if (currentState is! GameSessionReady) return;

    emit(
      GameSessionTimer(
        secretWord: currentState.secretWord,
        spyIndices: currentState.spyIndices,
        durationMinutes: _durationMinutes,
      ),
    );
  }

  void finishGame() {
    final currentState = state;
    if (currentState is! GameSessionTimer) return;

    emit(
      GameSessionSummary(
        secretWord: currentState.secretWord,
        playerCount: _playerCount,
        spyCount: _spyCount,
        durationMinutes: _durationMinutes,
      ),
    );
  }

  void prepareAnotherRound() {
    final cat = _category;
    if (cat == null) return;

    startGame(
      playerCount: _playerCount,
      spyCount: _spyCount,
      durationMinutes: _durationMinutes,
      category: cat,
    );
  }

  void reset() {
    _playedWordIds.clear();
    _category = null;
    emit(const GameSessionInitial());
  }
}
