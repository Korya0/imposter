import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/features/game/domain/entities/category_entity.dart';
import 'package:imposter/features/game/domain/services/game_engine.dart';
import 'package:imposter/features/game/presentation/controller/game_session_cubit/game_session_state.dart';

class GameSessionCubit extends Cubit<GameSessionState> {
  GameSessionCubit(this._gameEngine) : super(const GameSessionInitial());
  final GameEngine _gameEngine;

  List<String> _playerNames = const [];
  int _spyCount = 1;
  int _durationMinutes = 2;
  CategoryEntity? _category;
  final List<String> _playedWordIds = [];

  int get playerCount => _playerNames.length;
  List<String> get playerNames => _playerNames;
  int get spyCount => _spyCount;

  void startGame({
    required List<String> playerNames,
    required int spyCount,
    required int durationMinutes,
    required CategoryEntity category,
  }) {
    if (_category?.id != category.id) {
      _playedWordIds.clear();
    }

    _playerNames = playerNames;
    _spyCount = spyCount;
    _durationMinutes = durationMinutes;
    _category = category;

    final setup = _gameEngine.prepareRound(
      category: category,
      playerCount: playerNames.length,
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

    if (nextIndex < playerCount) {
      emit(
        GameSessionScanning(
          currentPlayerIndex: nextIndex,
          secretWord: word,
          spyIndices: spies,
        ),
      );
    } else {
      emit(
        GameSessionTimer(
          secretWord: word,
          spyIndices: spies,
          durationMinutes: _durationMinutes,
        ),
      );
    }
  }

  void startVoting() {
    final currentState = state;
    if (currentState is! GameSessionTimer) return;

    emit(
      GameSessionVoting(
        secretWord: currentState.secretWord,
        spyIndices: currentState.spyIndices,
      ),
    );
  }

  void finishGame(Map<int, List<int>> votedSpies) {
    final currentState = state;
    if (currentState is! GameSessionVoting) return;

    emit(
      GameSessionSummary(
        secretWord: currentState.secretWord,
        playerCount: playerCount,
        spyCount: _spyCount,
        durationMinutes: _durationMinutes,
        spyIndices: currentState.spyIndices,
        votedSpies: votedSpies,
      ),
    );
  }

  void prepareAnotherRound() {
    final cat = _category;
    if (cat == null) return;

    startGame(
      playerNames: _playerNames,
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
