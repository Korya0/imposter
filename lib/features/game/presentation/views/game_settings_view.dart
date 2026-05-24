import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_padding.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/presentation/widgets/custom_scroll_scaffold.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/utils/app_validators.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/presentation/controller/game_session_cubit/game_session_cubit.dart';
import 'package:imposter/features/game/presentation/controller/game_setup_cubit/game_setup_cubit.dart';
import 'package:imposter/features/game/presentation/widgets/game_settings/game_settings_list.dart';
import 'package:imposter/features/game/presentation/widgets/game_settings/start_button.dart';

class GameSettingsView extends StatelessWidget {
  const GameSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollScaffold(
      title: AppStrings.settings,
      slivers: [
        SliverPadding(
          padding: AppPadding.viewH18(context),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const GameSettingsList(),
              const AppGap(24),
              Center(
                child: StartButton(
                  onTap: () async {
                    final setup = context.read<GameSetupCubit>().state;
                    final hasInvalidName = setup.playerNames.any(
                      (name) => AppValidators.validatePlayerName(name) != null,
                    );
                    if (hasInvalidName) {
                      context.showAppToast(
                        AppStrings.playerNameValidationError,
                      );
                      return;
                    }
                    context.read<GameSessionCubit>().startGame(
                      playerNames: setup.playerNames,
                      spyCount: setup.spyCount,
                      durationMinutes: setup.durationMinutes,
                      category: setup.selectedCategory!,
                    );
                    await context.pushNamed(AppRoutes.game);
                  },
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
