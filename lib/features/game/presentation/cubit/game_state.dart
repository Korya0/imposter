import 'package:imposter/features/game/domain/entities/category_entity.dart';

sealed class GameState {
  final List<CategoryEntity> categories;
  final CategoryEntity? selectedCategory;
  final int playerCount;
  final int spyCount;
  final int durationMinutes;
  final int currentPlayerIndex;
  final String? secretWord;
  final List<int> spyIndices;

  const GameState({
    this.categories = const [],
    this.selectedCategory,
    this.playerCount = 3,
    this.spyCount = 1,
    this.durationMinutes = 2,
    this.currentPlayerIndex = 0,
    this.secretWord,
    this.spyIndices = const [],
  });
}

class GameInitial extends GameState {
  const GameInitial() : super();
}

class GameLoading extends GameState {
  const GameLoading({
    super.categories,
    super.selectedCategory,
    super.playerCount,
    super.spyCount,
    super.durationMinutes,
  });
}

class GameCategoriesLoaded extends GameState {
  const GameCategoriesLoaded({
    required super.categories,
    super.selectedCategory,
    super.playerCount,
    super.spyCount,
    super.durationMinutes,
  });
}

class GameScanning extends GameState {
  const GameScanning({
    required super.categories,
    required super.selectedCategory,
    required super.playerCount,
    required super.spyCount,
    required super.durationMinutes,
    required super.currentPlayerIndex,
    required super.secretWord,
    required super.spyIndices,
  });
}

class GameRevealing extends GameState {
  final bool isSpy;

  const GameRevealing({
    required super.categories,
    required super.selectedCategory,
    required super.playerCount,
    required super.spyCount,
    required super.durationMinutes,
    required super.currentPlayerIndex,
    required super.secretWord,
    required super.spyIndices,
    required this.isSpy,
  });
}

class GameReady extends GameState {
  const GameReady({
    required super.categories,
    required super.selectedCategory,
    required super.playerCount,
    required super.spyCount,
    required super.durationMinutes,
    required super.secretWord,
    required super.spyIndices,
  });
}

class GameTimer extends GameState {
  const GameTimer({
    required super.categories,
    required super.selectedCategory,
    required super.playerCount,
    required super.spyCount,
    required super.durationMinutes,
    required super.secretWord,
    required super.spyIndices,
  });
}

class GameSummary extends GameState {
  const GameSummary({
    required super.categories,
    required super.selectedCategory,
    required super.playerCount,
    required super.spyCount,
    required super.durationMinutes,
    required super.secretWord,
    required super.spyIndices,
  });
}

class GameError extends GameState {
  final String message;

  const GameError({
    required this.message,
    super.categories,
    super.selectedCategory,
    super.playerCount,
    super.spyCount,
    super.durationMinutes,
  });
}
