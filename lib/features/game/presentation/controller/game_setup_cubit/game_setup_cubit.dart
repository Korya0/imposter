import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/error/result.dart';
import 'package:imposter/features/game/domain/entities/category_entity.dart';
import 'package:imposter/features/game/domain/usecases/get_categories_usecase.dart';
import 'package:imposter/features/game/presentation/controller/game_setup_cubit/game_setup_state.dart';

class GameSetupCubit extends Cubit<GameSetupState> {
  GameSetupCubit(this._getCategoriesUsecase) : super(const GameSetupInitial());
  final GetCategoriesUsecase _getCategoriesUsecase;

  Future<void> init() async {
    if (state.categories.isNotEmpty) return;

    emit(
      GameSetupLoading(
        playerCount: state.playerCount,
        spyCount: state.spyCount,
        durationMinutes: state.durationMinutes,
        playerNames: state.playerNames,
      ),
    );

    final result = await _getCategoriesUsecase();

    if (result is Success<List<CategoryEntity>>) {
      emit(
        GameSetupLoaded(
          categories: result.data,
          playerCount: state.playerCount,
          spyCount: state.spyCount,
          durationMinutes: state.durationMinutes,
          playerNames: state.playerNames,
        ),
      );
    } else if (result is FailureResult<List<CategoryEntity>>) {
      emit(
        GameSetupError(
          message: result.failure.message,
          playerCount: state.playerCount,
          spyCount: state.spyCount,
          durationMinutes: state.durationMinutes,
          playerNames: state.playerNames,
        ),
      );
    }
  }

  void selectCategory(CategoryEntity category) {
    emit(
      GameSetupLoaded(
        categories: state.categories,
        selectedCategory: category,
        playerCount: state.playerCount,
        spyCount: state.spyCount,
        durationMinutes: state.durationMinutes,
        playerNames: state.playerNames,
      ),
    );
  }

  void updateSettings({
    int? players,
    int? spies,
    int? minutes,
    List<String>? playerNames,
  }) {
    final nextPlayerNames = List<String>.from(playerNames ?? state.playerNames);
    final nextPlayers = (players ?? nextPlayerNames.length).clamp(3, 12);

    // Adjust names list size if playerCount changed via number
    if (nextPlayerNames.length < nextPlayers) {
      for (var i = nextPlayerNames.length; i < nextPlayers; i++) {
        nextPlayerNames.add('${AppStrings.playerDefaultPrefix} ${i + 1}');
      }
    } else if (nextPlayerNames.length > nextPlayers) {
      nextPlayerNames.removeRange(nextPlayers, nextPlayerNames.length);
    }

    final nextSpies = (spies ?? state.spyCount).clamp(1, nextPlayers ~/ 2);
    final nextMinutes = (minutes ?? state.durationMinutes).clamp(1, 30);

    if (state is GameSetupLoaded || state is GameSetupError) {
      emit(
        GameSetupLoaded(
          categories: state.categories,
          selectedCategory: state.selectedCategory,
          playerCount: nextPlayers,
          spyCount: nextSpies,
          durationMinutes: nextMinutes,
          playerNames: nextPlayerNames,
        ),
      );
    } else {
      emit(
        GameSetupLoading(
          playerCount: nextPlayers,
          spyCount: nextSpies,
          durationMinutes: nextMinutes,
          categories: state.categories,
          selectedCategory: state.selectedCategory,
          playerNames: nextPlayerNames,
        ),
      );
    }
  }

  void updatePlayerName(int index, String newName) {
    if (index >= 0 && index < state.playerNames.length) {
      final names = List<String>.from(state.playerNames);
      names[index] = newName;
      updateSettings(playerNames: names);
    }
  }

  void addPlayer() {
    if (state.playerNames.length < 12) {
      final names = List<String>.from(state.playerNames);
      names.add('${AppStrings.playerDefaultPrefix} ${names.length + 1}');
      updateSettings(players: names.length, playerNames: names);
    }
  }

  void removePlayer() {
    if (state.playerNames.length > 3) {
      final names = List<String>.from(state.playerNames)..removeLast();
      updateSettings(players: names.length, playerNames: names);
    }
  }

  void incrementSpies() => updateSettings(spies: state.spyCount + 1);
  void decrementSpies() => updateSettings(spies: state.spyCount - 1);
  void incrementMinutes() => updateSettings(minutes: state.durationMinutes + 1);
  void decrementMinutes() => updateSettings(minutes: state.durationMinutes - 1);
}
