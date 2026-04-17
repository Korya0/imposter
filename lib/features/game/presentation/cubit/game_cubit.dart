import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/error/result.dart';
import 'package:imposter/features/game/domain/entities/category_entity.dart';
import 'package:imposter/features/game/domain/usecases/get_categories_usecase.dart';

import 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  final GetCategoriesUsecase _getCategoriesUsecase;

  GameCubit(this._getCategoriesUsecase) : super(const GameInitial());

  Future<void> init() async {
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
    if (state is GameCategoriesLoaded || state is GameError) {
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
  }

  void updateSettings({int? players, int? spies, int? minutes}) {
    emit(
      GameCategoriesLoaded(
        categories: state.categories,
        selectedCategory: state.selectedCategory,
        playerCount: (players ?? state.playerCount).clamp(3, 12),
        spyCount: (spies ?? state.spyCount).clamp(
          1,
          (players ?? state.playerCount) ~/ 2,
        ),
        durationMinutes: (minutes ?? state.durationMinutes).clamp(1, 30),
      ),
    );
  }

  void incrementPlayers() => updateSettings(players: state.playerCount + 1);
  void decrementPlayers() => updateSettings(players: state.playerCount - 1);
  void incrementSpies() => updateSettings(spies: state.spyCount + 1);
  void decrementSpies() => updateSettings(spies: state.spyCount - 1);
  void incrementMinutes() => updateSettings(minutes: state.durationMinutes + 1);
  void decrementMinutes() => updateSettings(minutes: state.durationMinutes - 1);

  void prepareRound() {
    if (state.selectedCategory == null) return;

    final random = Random();
    final word = state
        .selectedCategory!
        .words[random.nextInt(state.selectedCategory!.words.length)];

    final playerIndices = List.generate(state.playerCount, (index) => index)
      ..shuffle(random);
    final spies = playerIndices.take(state.spyCount).toList();

    emit(
      GameScanning(
        categories: state.categories,
        selectedCategory: state.selectedCategory,
        playerCount: state.playerCount,
        spyCount: state.spyCount,
        durationMinutes: state.durationMinutes,
        currentPlayerIndex: 0,
        secretWord: word.name,
        spyIndices: spies,
      ),
    );
  }

  void toggleReveal(bool reveal) {
    if (reveal && state is GameScanning) {
      emit(
        GameRevealing(
          categories: state.categories,
          selectedCategory: state.selectedCategory,
          playerCount: state.playerCount,
          spyCount: state.spyCount,
          durationMinutes: state.durationMinutes,
          currentPlayerIndex: state.currentPlayerIndex,
          secretWord: state.secretWord,
          spyIndices: state.spyIndices,
          isSpy: state.spyIndices.contains(state.currentPlayerIndex),
        ),
      );
    } else if (!reveal && state is GameRevealing) {
      nextPlayer();
    }
  }

  void nextPlayer() {
    final nextIndex = state.currentPlayerIndex + 1;

    if (nextIndex < state.playerCount) {
      emit(
        GameScanning(
          categories: state.categories,
          selectedCategory: state.selectedCategory,
          playerCount: state.playerCount,
          spyCount: state.spyCount,
          durationMinutes: state.durationMinutes,
          currentPlayerIndex: nextIndex,
          secretWord: state.secretWord,
          spyIndices: state.spyIndices,
        ),
      );
    } else {
      emit(
        GameReady(
          categories: state.categories,
          selectedCategory: state.selectedCategory,
          playerCount: state.playerCount,
          spyCount: state.spyCount,
          durationMinutes: state.durationMinutes,
          secretWord: state.secretWord,
          spyIndices: state.spyIndices,
        ),
      );
    }
  }

  void redoRound() {
    emit(
      GameScanning(
        categories: state.categories,
        selectedCategory: state.selectedCategory,
        playerCount: state.playerCount,
        spyCount: state.spyCount,
        durationMinutes: state.durationMinutes,
        currentPlayerIndex: 0,
        secretWord: state.secretWord,
        spyIndices: state.spyIndices,
      ),
    );
  }

  void startTimer() {
    emit(
      GameTimer(
        categories: state.categories,
        selectedCategory: state.selectedCategory,
        playerCount: state.playerCount,
        spyCount: state.spyCount,
        durationMinutes: state.durationMinutes,
        secretWord: state.secretWord,
        spyIndices: state.spyIndices,
      ),
    );
  }

  void finishGame() {
    emit(
      GameSummary(
        categories: state.categories,
        selectedCategory: state.selectedCategory,
        playerCount: state.playerCount,
        spyCount: state.spyCount,
        durationMinutes: state.durationMinutes,
        secretWord: state.secretWord,
        spyIndices: state.spyIndices,
      ),
    );
  }
}
