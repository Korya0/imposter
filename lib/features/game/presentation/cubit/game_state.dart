import 'package:imposter/features/game/domain/entities/category_entity.dart';

sealed class GameState {
  const GameState({
    this.playerCount = 3,
    this.spyCount = 1,
    this.durationMinutes = 2,
    this.categories = const [],
    this.selectedCategory,
  });
  final int playerCount;
  final int spyCount;
  final int durationMinutes;
  final List<CategoryEntity> categories;
  final CategoryEntity? selectedCategory;
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
  final int currentPlayerIndex;
  final String secretWord;
  final List<int> spyIndices;
}

class GameRevealing extends GameState {
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
  final int currentPlayerIndex;
  final String secretWord;
  final List<int> spyIndices;
  final bool isSpy;
}

class GameReady extends GameState {
  const GameReady({
    required super.categories,
    required CategoryEntity super.selectedCategory,
    required super.playerCount,
    required super.spyCount,
    required super.durationMinutes,
    required this.secretWord,
    required this.spyIndices,
  });
  final String secretWord;
  final List<int> spyIndices;
}

class GameTimer extends GameState {
  const GameTimer({
    required super.categories,
    required CategoryEntity super.selectedCategory,
    required super.playerCount,
    required super.spyCount,
    required super.durationMinutes,
    required this.secretWord,
    required this.spyIndices,
  });
  final String secretWord;
  final List<int> spyIndices;
}

class GameSummary extends GameState {
  const GameSummary({
    required super.categories,
    required CategoryEntity super.selectedCategory,
    required super.playerCount,
    required super.spyCount,
    required super.durationMinutes,
    required this.secretWord,
    required this.spyIndices,
  });
  final String secretWord;
  final List<int> spyIndices;
}

class GameError extends GameState {
  const GameError({
    required this.message,
    super.playerCount,
    super.spyCount,
    super.durationMinutes,
    super.categories,
    super.selectedCategory,
  });
  final String message;
}
