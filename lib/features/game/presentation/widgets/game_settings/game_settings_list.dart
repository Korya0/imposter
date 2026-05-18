import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_toast.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';
import 'package:imposter/features/game/presentation/cubit/game_state.dart';
import 'package:imposter/features/game/presentation/widgets/game_settings/game_setting_item.dart';

class GameSettingsList extends StatelessWidget {
  const GameSettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();

    return Column(
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
        )
            .animate(key: const ValueKey('players_setting_anim'))
            .fadeIn(delay: 100.ms, duration: 600.ms)
            .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),

        SizedBox(height: context.p(20)),

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
        )
            .animate(key: const ValueKey('spies_setting_anim'))
            .fadeIn(delay: 250.ms, duration: 600.ms)
            .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),

        SizedBox(height: context.p(20)),

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
        )
            .animate(key: const ValueKey('minutes_setting_anim'))
            .fadeIn(delay: 400.ms, duration: 600.ms)
            .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),
      ],
    );
  }
}
