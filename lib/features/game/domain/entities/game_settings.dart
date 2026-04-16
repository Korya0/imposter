import 'category_entity.dart';

class GameSettings {
  final int totalPlayers;
  final int impostersCount;
  final int timerDuration;
  final CategoryEntity selectedCategory;

  const GameSettings({
    required this.totalPlayers,
    required this.impostersCount,
    required this.timerDuration,
    required this.selectedCategory,
  });

  GameSettings copyWith({
    int? totalPlayers,
    int? impostersCount,
    int? timerDuration,
    CategoryEntity? selectedCategory,
  }) {
    return GameSettings(
      totalPlayers: totalPlayers ?? this.totalPlayers,
      impostersCount: impostersCount ?? this.impostersCount,
      timerDuration: timerDuration ?? this.timerDuration,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
