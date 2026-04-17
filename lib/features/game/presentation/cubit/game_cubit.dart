import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/error/result.dart';
import 'package:imposter/core/utils/app_logger.dart';
import 'package:imposter/features/game/domain/entities/category_entity.dart';
import 'package:imposter/features/game/domain/usecases/get_categories_usecase.dart';

import 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  final GetCategoriesUsecase _getCategoriesUsecase;

  GameCubit(this._getCategoriesUsecase) : super(const GameInitial());

  Future<void> init() async {
    AppLogger.info('Initializing GameCubit and loading categories');
    emit(
      GameLoading(
        playerCount: state.playerCount,
        spyCount: state.spyCount,
        durationMinutes: state.durationMinutes,
      ),
    );

    final result = await _getCategoriesUsecase();

    if (result is Success<List<CategoryEntity>>) {
      AppLogger.info('Successfully loaded ${result.data.length} categories');
      emit(
        GameCategoriesLoaded(
          categories: result.data,
          playerCount: state.playerCount,
          spyCount: state.spyCount,
          durationMinutes: state.durationMinutes,
        ),
      );
    } else if (result is FailureResult<List<CategoryEntity>>) {
      AppLogger.error('Failed to load categories: ${result.failure.message}');
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
    AppLogger.info('Category selected: ${category.name}');
    final currentState = state;
    if (currentState is GameCategoriesLoaded) {
      emit(
        GameCategoriesLoaded(
          categories: currentState.categories,
          selectedCategory: category,
          playerCount: state.playerCount,
          spyCount: state.spyCount,
          durationMinutes: state.durationMinutes,
        ),
      );
    } else if (currentState is GameError) {
      emit(
        GameCategoriesLoaded(
          categories: const [],
          selectedCategory: category,
          playerCount: state.playerCount,
          spyCount: state.spyCount,
          durationMinutes: state.durationMinutes,
        ),
      );
    }
  }

  void updateSettings({int? players, int? spies, int? minutes}) {
    final nextPlayers = (players ?? state.playerCount).clamp(3, 12);
    final nextSpies = (spies ?? state.spyCount).clamp(
      1,
      nextPlayers ~/ 2,
    );
    final nextMinutes = (minutes ?? state.durationMinutes).clamp(1, 30);

    AppLogger.info('Updating settings: players=$nextPlayers, spies=$nextSpies, minutes=$nextMinutes');

    final currentState = state;
    if (currentState is GameCategoriesLoaded) {
      emit(
        GameCategoriesLoaded(
          categories: currentState.categories,
          selectedCategory: currentState.selectedCategory,
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
    final currentState = state;

    final (cats, selCat) = switch (currentState) {
      GameCategoriesLoaded(categories: final c, selectedCategory: final sc) => (c, sc),
      GameScanning(categories: final c, selectedCategory: final sc) => (c, sc),
      GameRevealing(categories: final c, selectedCategory: final sc) => (c, sc),
      GameReady(categories: final c, selectedCategory: final sc) => (c, sc),
      GameTimer(categories: final c, selectedCategory: final sc) => (c, sc),
      GameSummary(categories: final c, selectedCategory: final sc) => (c, sc),
      _ => (const <CategoryEntity>[], null),
    };

    if (selCat == null) {
      AppLogger.warning('Cannot prepare round: Missing category or invalid state');
      return;
    }

    AppLogger.info('Preparing round for category: ${selCat.name}');

    final random = Random();
    final word = selCat.words[random.nextInt(selCat.words.length)];

    final playerIndices = List.generate(state.playerCount, (index) => index)
      ..shuffle(random);
    final spies = playerIndices.take(state.spyCount).toList();

    emit(
      GameScanning(
        categories: cats,
        selectedCategory: selCat,
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
    final currentState = state;
    if (reveal && currentState is GameScanning) {
      emit(
        GameRevealing(
          categories: currentState.categories,
          selectedCategory: currentState.selectedCategory,
          playerCount: state.playerCount,
          spyCount: state.spyCount,
          durationMinutes: state.durationMinutes,
          currentPlayerIndex: currentState.currentPlayerIndex,
          secretWord: currentState.secretWord,
          spyIndices: currentState.spyIndices,
          isSpy: currentState.spyIndices.contains(currentState.currentPlayerIndex),
        ),
      );
    } else if (!reveal && currentState is GameRevealing) {
      nextPlayer();
    }
  }

  void nextPlayer() {
    final currentState = state;
    if (currentState is! GameScanning && currentState is! GameRevealing) {
      return;
    }

    final currentIndex = currentState is GameScanning
        ? currentState.currentPlayerIndex
        : (currentState as GameRevealing).currentPlayerIndex;
    final cats = currentState is GameScanning
        ? currentState.categories
        : (currentState as GameRevealing).categories;
    final selCat = currentState is GameScanning
        ? currentState.selectedCategory
        : (currentState as GameRevealing).selectedCategory;
    final word = currentState is GameScanning
        ? currentState.secretWord
        : (currentState as GameRevealing).secretWord;
    final spies = currentState is GameScanning
        ? currentState.spyIndices
        : (currentState as GameRevealing).spyIndices;

    final nextIndex = currentIndex + 1;

    if (nextIndex < state.playerCount) {
      emit(
        GameScanning(
          categories: cats,
          selectedCategory: selCat,
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
          categories: cats,
          selectedCategory: selCat,
          playerCount: state.playerCount,
          spyCount: state.spyCount,
          durationMinutes: state.durationMinutes,
          secretWord: word,
          spyIndices: spies,
        ),
      );
    }
  }

  void redoRound() {
    final currentState = state;
    if (currentState is! GameReady &&
        currentState is! GameTimer &&
        currentState is! GameSummary) {
      return;
    }

    final (cats, selCat, word, spies) = switch (currentState) {
      GameReady(
        categories: final c,
        selectedCategory: final sc,
        secretWord: final w,
        spyIndices: final si
      ) =>
        (c, sc, w, si),
      GameTimer(
        categories: final c,
        selectedCategory: final sc,
        secretWord: final w,
        spyIndices: final si
      ) =>
        (c, sc, w, si),
      GameSummary(
        categories: final c,
        selectedCategory: final sc,
        secretWord: final w,
        spyIndices: final si
      ) =>
        (c, sc, w, si),
      _ => (const <CategoryEntity>[], null, '', const <int>[])
    };

    if (selCat == null) return;

    emit(
      GameScanning(
        categories: cats,
        selectedCategory: selCat,
        playerCount: state.playerCount,
        spyCount: state.spyCount,
        durationMinutes: state.durationMinutes,
        currentPlayerIndex: 0,
        secretWord: word,
        spyIndices: spies,
      ),
    );
  }

  void startTimer() {
    final currentState = state;
    if (currentState is! GameReady) return;

    emit(
      GameTimer(
        categories: currentState.categories,
        selectedCategory: currentState.selectedCategory,
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
        categories: currentState.categories,
        selectedCategory: currentState.selectedCategory,
        playerCount: state.playerCount,
        spyCount: state.spyCount,
        durationMinutes: state.durationMinutes,
        secretWord: currentState.secretWord,
        spyIndices: currentState.spyIndices,
      ),
    );
  }
}
