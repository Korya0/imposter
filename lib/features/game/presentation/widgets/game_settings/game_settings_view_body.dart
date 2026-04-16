import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/widgets/custom_app_bar.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';
import 'package:imposter/features/game/presentation/cubit/game_state.dart';
import 'package:imposter/features/game/presentation/widgets/game_settings/game_setting_item.dart';
import 'package:imposter/features/game/presentation/widgets/game_settings/start_button.dart';

class GameSettingsViewBody extends StatelessWidget {
  const GameSettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();

    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: (context.height * 0.05).clamp(12, 32),
          ),
          child: Column(
            children: [
              const CustomAppBar(),

              GameSettingItem(
                    iconPath: AppAssets.peopleGroupSvg,
                    title: AppStrings.numberOfPlayers,
                    value: state.playerCount.toString(),
                    onIncrement: cubit.incrementPlayers,
                    onDecrement: cubit.decrementPlayers,
                  )
                  .animate()
                  .fadeIn(delay: 100.ms, duration: 600.ms)
                  .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),

              SizedBox(height: (context.height * 0.05).clamp(12, 32)),

              GameSettingItem(
                    iconPath: AppAssets.spySvg,
                    title: AppStrings.numberOfSpies,
                    value: state.spyCount.toString(),
                    onIncrement: cubit.incrementSpies,
                    onDecrement: cubit.decrementSpies,
                  )
                  .animate()
                  .fadeIn(delay: 250.ms, duration: 600.ms)
                  .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),

              SizedBox(height: (context.height * 0.01).clamp(12, 32)),

              GameSettingItem(
                    iconPath: AppAssets.timeOclockSvg,
                    title: AppStrings.numberOfMinutes,
                    value: state.durationMinutes.toString(),
                    onIncrement: cubit.incrementMinutes,
                    onDecrement: cubit.decrementMinutes,
                  )
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 600.ms)
                  .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),

              SizedBox(height: (context.height * 0.05).clamp(18, 42)),

              StartButton(
                onTap: () async {
                  cubit.prepareRound();
                  await context.pushNamed(AppRoutes.game);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
