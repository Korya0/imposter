import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_divider.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/presentation/widgets/app_toast.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/presentation/controller/game_setup_cubit/game_setup_cubit.dart';
import 'package:imposter/features/game/presentation/controller/game_setup_cubit/game_setup_state.dart';
import 'package:imposter/features/game/presentation/widgets/game_settings/compact_setting_card.dart';
import 'package:imposter/features/game/presentation/widgets/game_settings/player_names_management_card.dart';

class GameSettingsList extends StatelessWidget {
  const GameSettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: context.p(24),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: context.p(12),
          children: [
            AppTextWidget(
              AppStrings.numberOfPlayers,
              style: AppTextStyles.font22W400Primary,
            ),
            const PlayerNamesManagementCard(),
            const AppDivider(),
          ],
        ),
        Row(
          spacing: context.p(12),
          children: const [
            Expanded(child: _SpiesSettingSelector()),
            Expanded(child: _MinutesSettingSelector()),
          ],
        ),
      ],
    );
  }
}

class _SpiesSettingSelector extends StatelessWidget {
  const _SpiesSettingSelector();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameSetupCubit>();
    return BlocSelector<GameSetupCubit, GameSetupState, (int, int)>(
      selector: (state) => (state.spyCount, state.playerCount),
      builder: (context, data) {
        final spyCount = data.$1;
        final playerCount = data.$2;
        return CompactSettingCard(
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
    );
  }
}

class _MinutesSettingSelector extends StatelessWidget {
  const _MinutesSettingSelector();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameSetupCubit>();
    return BlocSelector<GameSetupCubit, GameSetupState, int>(
      selector: (state) => state.durationMinutes,
      builder: (context, durationMinutes) {
        return CompactSettingCard(
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
    );
  }
}
