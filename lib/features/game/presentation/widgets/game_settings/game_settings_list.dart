import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_paddings.dart';
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

    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Column(
          children: [
            // Players Setting
            GameSettingItem(
              iconPath: AppAssets.peopleGroupSvg,
              title: AppStrings.numberOfPlayers,
              value: state.playerCount.toString(),
              onIncrement: () {
                if (state.playerCount < 12) {
                  cubit.incrementPlayers();
                } else {
                  AppToast.show(context, AppStrings.maxPlayersReached);
                }
              },
              onDecrement: () {
                if (state.playerCount > 3) {
                  cubit.decrementPlayers();
                } else {
                  AppToast.show(context, AppStrings.minPlayersReached);
                }
              },
            )
                .animate()
                .fadeIn(delay: 100.ms, duration: 600.ms)
                .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),

            SizedBox(height: AppPaddings.heightH01(context)),

            // Spies Setting
            GameSettingItem(
              iconPath: AppAssets.spySvg,
              title: AppStrings.numberOfSpies,
              value: state.spyCount.toString(),
              onIncrement: () {
                if (state.spyCount < state.playerCount ~/ 2) {
                  cubit.incrementSpies();
                } else {
                  AppToast.show(context, AppStrings.maxSpiesReached);
                }
              },
              onDecrement: () {
                if (state.spyCount > 1) {
                  cubit.decrementSpies();
                } else {
                  AppToast.show(context, AppStrings.minSpiesReached);
                }
              },
            )
                .animate()
                .fadeIn(delay: 250.ms, duration: 600.ms)
                .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),

            SizedBox(height: AppPaddings.heightH01(context)),

            // Minutes Setting
            GameSettingItem(
              iconPath: AppAssets.timeOclockSvg,
              title: AppStrings.numberOfMinutes,
              value: state.durationMinutes.toString(),
              onIncrement: () {
                if (state.durationMinutes < 30) {
                  cubit.incrementMinutes();
                } else {
                  AppToast.show(context, AppStrings.maxMinutesReached);
                }
              },
              onDecrement: () {
                if (state.durationMinutes > 1) {
                  cubit.decrementMinutes();
                } else {
                  AppToast.show(context, AppStrings.minMinutesReached);
                }
              },
            )
                .animate()
                .fadeIn(delay: 400.ms, duration: 600.ms)
                .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),
          ],
        );
      },
    );
  }
}
