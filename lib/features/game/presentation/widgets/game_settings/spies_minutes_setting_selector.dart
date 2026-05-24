import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_divider.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/presentation/controller/game_setup_cubit/game_setup_cubit.dart';
import 'package:imposter/features/game/presentation/controller/game_setup_cubit/game_setup_state.dart';
import 'package:imposter/features/game/presentation/widgets/game_settings/game_setting_header.dart';
import 'package:imposter/features/game/presentation/widgets/game_settings/wobbly_numeric_adjuster.dart';

class SpiesMinutesSettingSelector extends StatelessWidget {
  const SpiesMinutesSettingSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: SpiesSettingSelector(),
          ),
          RotatedBox(
            quarterTurns: 1,
            child: AppDivider(),
          ),
          Expanded(
            child: MinutesSettingSelector(),
          ),
        ],
      ),
    );
  }
}

class SpiesSettingSelector extends StatelessWidget {
  const SpiesSettingSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameSetupCubit>();
    return BlocSelector<GameSetupCubit, GameSetupState, (int, int)>(
      selector: (state) => (state.spyCount, state.playerCount),
      builder: (context, data) {
        final spyCount = data.$1;
        final playerCount = data.$2;

        return Column(
          mainAxisSize: MainAxisSize.min,
          spacing: context.p(16),
          children: [
            // Top: Icon + Title
            const GameSettingHeader(
              iconAsset: AppAssets.spySvg,
              title: AppStrings.numberOfSpies,
            ),

            // Bottom: Sleek Wobbly Pill Adjuster
            WobblyNumericAdjuster(
              value: spyCount,
              onDecrement: spyCount > 1 ? cubit.decrementSpies : null,
              onIncrement: spyCount < playerCount ~/ 2
                  ? cubit.incrementSpies
                  : null,
            ),
          ],
        );
      },
    );
  }
}

class MinutesSettingSelector extends StatelessWidget {
  const MinutesSettingSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameSetupCubit>();
    return BlocSelector<GameSetupCubit, GameSetupState, int>(
      selector: (state) => state.durationMinutes,
      builder: (context, durationMinutes) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          spacing: context.p(16),
          children: [
            // Top: Icon + Title
            const GameSettingHeader(
              iconAsset: AppAssets.timeOclockSvg,
              title: AppStrings.numberOfMinutes,
            ),

            // Bottom: Sleek Wobbly Pill Adjuster
            WobblyNumericAdjuster(
              value: durationMinutes,
              onDecrement: durationMinutes > 1
                  ? cubit.decrementMinutes
                  : null,
              onIncrement: durationMinutes < 30
                  ? cubit.incrementMinutes
                  : null,
            ),
          ],
        );
      },
    );
  }
}
