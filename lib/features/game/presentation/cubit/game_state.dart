import 'package:imposter/features/game/domain/entities/category_entity.dart';

sealed class GameState {
  final int playerCount;
  final int spyCount;
  final int durationMinutes;
  final List<CategoryEntity> categories;
  final CategoryEntity? selectedCategory;

  const GameState({
    this.playerCount = 3,
    this.spyCount = 1,
    this.durationMinutes = 2,
    this.categories = const [],
    this.selectedCategory,
  });
}

class GameInitial extends GameState {
  const GameInitial() : super();
}

class GameLoading extends GameState {
  const GameLoading({
    super.playerCount,
    super.spyCount,
    super.durationMinutes,
    super.categories,
    super.selectedCategory,
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
  final int currentPlayerIndex;
  final String secretWord;
  final List<int> spyIndices;

  const GameScanning({
    required super.categories,
    required CategoryEntity super.selectedCategory,
    required super.playerCount,
    required super.spyCount,
    required super.durationMinutes,
    required this.currentPlayerIndex,
    required this.secretWord,
    required this.spyIndices,
  });
}

class GameRevealing extends GameState {
  final int currentPlayerIndex;
  final String secretWord;
  final List<int> spyIndices;
  final bool isSpy;

  const GameRevealing({
    required super.categories,
    required CategoryEntity super.selectedCategory,
    required super.playerCount,
    required super.spyCount,
    required super.durationMinutes,
    required this.currentPlayerIndex,
    required this.secretWord,
    required this.spyIndices,
    required this.isSpy,
  });
}

class GameReady extends GameState {
  final String secretWord;
  final List<int> spyIndices;

  const GameReady({
    required super.categories,
    required CategoryEntity super.selectedCategory,
    required super.playerCount,
    required super.spyCount,
    required super.durationMinutes,
    required this.secretWord,
    required this.spyIndices,
  });
}

class GameTimer extends GameState {
  final String secretWord;
  final List<int> spyIndices;

  const GameTimer({
    required super.categories,
    required CategoryEntity super.selectedCategory,
    required super.playerCount,
    required super.spyCount,
    required super.durationMinutes,
    required this.secretWord,
    required this.spyIndices,
  });
}

class GameSummary extends GameState {
  final String secretWord;
  final List<int> spyIndices;

  const GameSummary({
    required super.categories,
    required CategoryEntity super.selectedCategory,
    required super.playerCount,
    required super.spyCount,
    required super.durationMinutes,
    required this.secretWord,
    required this.spyIndices,
  });
}

class GameError extends GameState {
  final String message;

  const GameError({
    required this.message,
    super.playerCount,
    super.spyCount,
    super.durationMinutes,
    super.categories,
    super.selectedCategory,
  });
}
