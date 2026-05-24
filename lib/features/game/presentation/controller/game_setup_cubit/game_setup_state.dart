import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/features/game/domain/entities/category_entity.dart';

sealed class GameSetupState {
  const GameSetupState({
    this.playerCount = 3,
    this.spyCount = 1,
    this.durationMinutes = 2,
    this.categories = const [],
    this.selectedCategory,
    this.playerNames = const [
      '${AppStrings.playerDefaultPrefix} 1',
      '${AppStrings.playerDefaultPrefix} 2',
      '${AppStrings.playerDefaultPrefix} 3',
    ],
  });
  final int playerCount;
  final int spyCount;
  final int durationMinutes;
  final List<CategoryEntity> categories;
  final CategoryEntity? selectedCategory;
  final List<String> playerNames;
}

class GameSetupInitial extends GameSetupState {
  const GameSetupInitial() : super();
}

class GameSetupLoading extends GameSetupState {
  const GameSetupLoading({
    super.playerCount,
    super.spyCount,
    super.durationMinutes,
    super.categories,
    super.selectedCategory,
    super.playerNames,
  });
}

class GameSetupLoaded extends GameSetupState {
  const GameSetupLoaded({
    required super.categories,
    super.selectedCategory,
    super.playerCount,
    super.spyCount,
    super.durationMinutes,
    super.playerNames,
  });
}

class GameSetupError extends GameSetupState {
  const GameSetupError({
    required this.message,
    super.playerCount,
    super.spyCount,
    super.durationMinutes,
    super.categories,
    super.selectedCategory,
    super.playerNames,
  });
  final String message;
}
