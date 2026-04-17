import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/error/result.dart';
import 'package:imposter/core/utils/app_logger.dart';
import 'package:imposter/features/game/domain/entities/category_entity.dart';
import 'package:imposter/features/game/domain/services/game_engine.dart';
import 'package:imposter/features/game/domain/usecases/get_categories_usecase.dart';

import 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  final GetCategoriesUsecase _getCategoriesUsecase;
  final GameEngine _gameEngine;

  GameCubit(
    this._getCategoriesUsecase,
    this._gameEngine,
  ) : super(const GameInitial());

  Future<void> init() async {
    if (state.categories.isNotEmpty) return;

    emit(
      GameLoading(
        playerCount: state.playerCount,
        spyCount: state.spyCount,
        durationMinutes: state.durationMinutes,
      ),
    );

    final result = await _getCategoriesUsecase();

    if (result is Success<List<CategoryEntity>>) {
      emit(
        GameCategoriesLoaded(
          categories: result.data,
          playerCount: state.playerCount,
          spyCount: state.spyCount,
          durationMinutes: state.durationMinutes,
        ),
      );
    } else if (result is FailureResult<List<CategoryEntity>>) {
      emit(
        GameError(
          message: result.failure.message,
          playerCount: state.playerCount,
          spyCount: state.spyCount,
          durationMinutes: state.durationMinutes,
        ),
      );
    }
  }

  void selectCategory(CategoryEntity category) {
    emit(
      GameCategoriesLoaded(
        categories: state.categories,
        selectedCategory: category,
        playerCount: state.playerCount,
        spyCount: state.spyCount,
        durationMinutes: state.durationMinutes,
      ),
    );
  }

  void updateSettings({int? players, int? spies, int? minutes}) {
    final nextPlayers = (players ?? state.playerCount).clamp(3, 12);
    final nextSpies = (spies ?? state.spyCount).clamp(1, nextPlayers ~/ 2);
    final nextMinutes = (minutes ?? state.durationMinutes).clamp(1, 30);

    if (state is GameCategoriesLoaded ||
        state is GameScanning ||
        state is GameRevealing ||
        state is GameReady ||
        state is GameTimer ||
        state is GameSummary) {
      emit(
        GameCategoriesLoaded(
          categories: state.categories,
          selectedCategory: state.selectedCategory,
          playerCount: nextPlayers,
          spyCount: nextSpies,
          durationMinutes: nextMinutes,
        ),
      );
    } else {
      emit(
        GameLoading(
          playerCount: nextPlayers,
          spyCount: nextSpies,
          durationMinutes: nextMinutes,
          categories: state.categories,
          selectedCategory: state.selectedCategory,
        ),
      );
    }
  }

  void incrementPlayers() => updateSettings(players: state.playerCount + 1);
  void decrementPlayers() => updateSettings(players: state.playerCount - 1);
  void incrementSpies() => updateSettings(spies: state.spyCount + 1);
  void decrementSpies() => updateSettings(spies: state.spyCount - 1);
  void incrementMinutes() => updateSettings(minutes: state.durationMinutes + 1);
  void decrementMinutes() => updateSettings(minutes: state.durationMinutes - 1);

  void prepareRound() {
    final selCat = state.selectedCategory;

    if (selCat == null) {
      AppLogger.warning('Cannot prepare round: Missing category');
      return;
    }

    final setup = _gameEngine.prepareRound(
      category: selCat,
      playerCount: state.playerCount,
      spyCount: state.spyCount,
    );

    emit(
      GameScanning(
        categories: state.categories,
        selectedCategory: selCat,
        playerCount: state.playerCount,
        spyCount: state.spyCount,
        durationMinutes: state.durationMinutes,
        currentPlayerIndex: 0,
        secretWord: setup.secretWord.name,
        spyIndices: setup.spyIndices,
      ),
    );
  }

  void toggleReveal(bool reveal) {
    final currentState = state;
    if (reveal && currentState is GameScanning) {
      emit(
        GameRevealing(
          categories: state.categories,
          selectedCategory: state.selectedCategory!,
          playerCount: state.playerCount,
          spyCount: state.spyCount,
          durationMinutes: state.durationMinutes,
          currentPlayerIndex: currentState.currentPlayerIndex,
          secretWord: currentState.secretWord,
          spyIndices: currentState.spyIndices,
          isSpy: currentState.spyIndices.contains(
            currentState.currentPlayerIndex,
          ),
        ),
      );
    } else if (!reveal && currentState is GameRevealing) {
      nextPlayer();
    }
  }

  void nextPlayer() {
    final currentState = state;
    var index = 0;
    var word = '';
    var spies = <int>[];

    if (currentState is GameScanning) {
      index = currentState.currentPlayerIndex;
      word = currentState.secretWord;
      spies = currentState.spyIndices;
    } else if (currentState is GameRevealing) {
      index = currentState.currentPlayerIndex;
      word = currentState.secretWord;
      spies = currentState.spyIndices;
    } else {
      return;
    }

    final nextIndex = index + 1;

    if (nextIndex < state.playerCount) {
      emit(
        GameScanning(
          categories: state.categories,
          selectedCategory: state.selectedCategory!,
          playerCount: state.playerCount,
          spyCount: state.spyCount,
          durationMinutes: state.durationMinutes,
          currentPlayerIndex: nextIndex,
          secretWord: word,
          spyIndices: spies,
        ),
      );
    } else {
      emit(
        GameReady(
          categories: state.categories,
          selectedCategory: state.selectedCategory!,
          playerCount: state.playerCount,
          spyCount: state.spyCount,
          durationMinutes: state.durationMinutes,
          secretWord: word,
          spyIndices: spies,
        ),
      );
    }
  }

  void startTimer() {
    final currentState = state;
    if (currentState is! GameReady) return;

    emit(
      GameTimer(
        categories: state.categories,
        selectedCategory: state.selectedCategory!,
        playerCount: state.playerCount,
        spyCount: state.spyCount,
        durationMinutes: state.durationMinutes,
        secretWord: currentState.secretWord,
        spyIndices: currentState.spyIndices,
      ),
    );
  }

  void finishGame() {
    final currentState = state;
    if (currentState is! GameTimer) return;

    emit(
      GameSummary(
        categories: state.categories,
        selectedCategory: state.selectedCategory!,
        playerCount: state.playerCount,
        spyCount: state.spyCount,
        durationMinutes: state.durationMinutes,
        secretWord: currentState.secretWord,
        spyIndices: currentState.spyIndices,
      ),
    );
  }
}
