import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_toast.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';
import 'package:imposter/features/game/presentation/cubit/game_state.dart';
import 'package:imposter/features/game/presentation/widgets/game_settings/game_setting_item.dart';

class GameSettingsList extends StatelessWidget {
  const GameSettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();

    return context.isLandscape
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: context.p(22),
            children: [ 
              // Players Setting
              BlocSelector<GameCubit, GameState, int>(
                selector: (state) => state.playerCount,
                builder: (context, playerCount) {
                  return GameSettingItem(
                    iconPath: AppAssets.peopleGroupSvg,
                    title: AppStrings.numberOfPlayers,
                    value: playerCount.toString(),
                    onIncrement: () {
                      if (playerCount < 12) {
                        cubit.incrementPlayers();
                      } else {
                        AppToast.show(context, AppStrings.maxPlayersReached);
                      }
                    },
                    onDecrement: () {
                      if (playerCount > 3) {
                        cubit.decrementPlayers();
                      } else {
                        AppToast.show(context, AppStrings.minPlayersReached);
                      }
                    },
                  );
                },
              ),

              // Spies Setting
              BlocSelector<GameCubit, GameState, (int, int)>(
                selector: (state) => (state.spyCount, state.playerCount),
                builder: (context, data) {
                  final spyCount = data.$1;
                  final playerCount = data.$2;
                  return GameSettingItem(
                    iconPath: AppAssets.spySvg,
                    title: AppStrings.numberOfSpies,
                    value: spyCount.toString(),
                    onIncrement: () {
                      if (spyCount < playerCount ~/ 2) {
                        cubit.incrementSpies();
                      } else {
                        AppToast.show(context, AppStrings.maxSpiesReached);
                      }
                    },
                    onDecrement: () {
                      if (spyCount > 1) {
                        cubit.decrementSpies();
                      } else {
                        AppToast.show(context, AppStrings.minSpiesReached);
                      }
                    },
                  );
                },
              ),

              // Minutes Setting
              BlocSelector<GameCubit, GameState, int>(
                selector: (state) => state.durationMinutes,
                builder: (context, durationMinutes) {
                  return GameSettingItem(
                    iconPath: AppAssets.timeOclockSvg,
                    title: AppStrings.numberOfMinutes,
                    value: durationMinutes.toString(),
                    onIncrement: () {
                      if (durationMinutes < 30) {
                        cubit.incrementMinutes();
                      } else {
                        AppToast.show(context, AppStrings.maxMinutesReached);
                      }
                    },
                    onDecrement: () {
                      if (durationMinutes > 1) {
                        cubit.decrementMinutes();
                      } else {
                        AppToast.show(context, AppStrings.minMinutesReached);
                      }
                    },
                  );
                },
              ),
            ],
          )
        : Column(
            spacing: context.p(22),
            children: [
              // Players Setting
              BlocSelector<GameCubit, GameState, int>(
                selector: (state) => state.playerCount,
                builder: (context, playerCount) {
                  return GameSettingItem(
                    iconPath: AppAssets.peopleGroupSvg,
                    title: AppStrings.numberOfPlayers,
                    value: playerCount.toString(),
                    onIncrement: () {
                      if (playerCount < 12) {
                        cubit.incrementPlayers();
                      } else {
                        AppToast.show(context, AppStrings.maxPlayersReached);
                      }
                    },
                    onDecrement: () {
                      if (playerCount > 3) {
                        cubit.decrementPlayers();
                      } else {
                        AppToast.show(context, AppStrings.minPlayersReached);
                      }
                    },
                  );
                },
              ),

              // Spies Setting
              BlocSelector<GameCubit, GameState, (int, int)>(
                selector: (state) => (state.spyCount, state.playerCount),
                builder: (context, data) {
                  final spyCount = data.$1;
                  final playerCount = data.$2;
                  return GameSettingItem(
                    iconPath: AppAssets.spySvg,
                    title: AppStrings.numberOfSpies,
                    value: spyCount.toString(),
                    onIncrement: () {
                      if (spyCount < playerCount ~/ 2) {
                        cubit.incrementSpies();
                      } else {
                        AppToast.show(context, AppStrings.maxSpiesReached);
                      }
                    },
                    onDecrement: () {
                      if (spyCount > 1) {
                        cubit.decrementSpies();
                      } else {
                        AppToast.show(context, AppStrings.minSpiesReached);
                      }
                    },
                  );
                },
              ),

              // Minutes Setting
              BlocSelector<GameCubit, GameState, int>(
                selector: (state) => state.durationMinutes,
                builder: (context, durationMinutes) {
                  return GameSettingItem(
                    iconPath: AppAssets.timeOclockSvg,
                    title: AppStrings.numberOfMinutes,
                    value: durationMinutes.toString(),
                    onIncrement: () {
                      if (durationMinutes < 30) {
                        cubit.incrementMinutes();
                      } else {
                        AppToast.show(context, AppStrings.maxMinutesReached);
                      }
                    },
                    onDecrement: () {
                      if (durationMinutes > 1) {
                        cubit.decrementMinutes();
                      } else {
                        AppToast.show(context, AppStrings.minMinutesReached);
                      }
                    },
                  );
                },
              ),
            ],
          );
  }
}
