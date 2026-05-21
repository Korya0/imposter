import 'package:flutter_bloc/flutter_bloc.dart';
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
        ),
      );
    } else if (result is FailureResult<List<CategoryEntity>>) {
      emit(
        GameSetupError(
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
      GameSetupLoaded(
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

    if (state is GameSetupLoaded || state is GameSetupError) {
      emit(
        GameSetupLoaded(
          categories: state.categories,
          selectedCategory: state.selectedCategory,
          playerCount: nextPlayers,
          spyCount: nextSpies,
          durationMinutes: nextMinutes,
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
}
