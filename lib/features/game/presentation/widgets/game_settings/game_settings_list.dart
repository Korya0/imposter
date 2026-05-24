import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_divider.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/presentation/widgets/app_value_adjuster.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/presentation/controller/game_setup_cubit/game_setup_cubit.dart';
import 'package:imposter/features/game/presentation/controller/game_setup_cubit/game_setup_state.dart';
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
            Row(
              spacing: context.p(12),
              children: [
                SvgPicture.asset(
                  AppAssets.peopleGroupSvg,
                  width: context.s(20),
                  height: context.s(20),
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
                AppTextWidget(
                  AppStrings.numberOfPlayers,
                  style: AppTextStyles.font22W400Primary,
                ),
              ],
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
          onIncrement: spyCount < playerCount ~/ 2
              ? cubit.incrementSpies
              : null,
          onDecrement: spyCount > 1 ? cubit.decrementSpies : null,
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
          onIncrement: durationMinutes < 30 ? cubit.incrementMinutes : null,
          onDecrement: durationMinutes > 1 ? cubit.decrementMinutes : null,
        );
      },
    );
  }
}

class CompactSettingCard extends StatelessWidget {
  const CompactSettingCard({
    required this.iconPath,
    required this.title,
    required this.value,
    this.onIncrement,
    this.onDecrement,
    super.key,
  });
  final String iconPath;
  final String title;
  final String value;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: context.p(8),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: context.p(12),
          children: [
            SvgPicture.asset(
              iconPath,
              width: context.s(20),
              height: context.s(20),
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            AppTextWidget(title, style: AppTextStyles.font16W700Primary),
          ],
        ),
        AppValueAdjuster(
          value: value,
          width: context.w(30),
          onIncrement: onIncrement,
          onDecrement: onDecrement,
        ),
      ],
    );
  }
}
