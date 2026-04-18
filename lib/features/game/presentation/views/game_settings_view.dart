import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/presentation/widgets/custom_app_bar.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';
import 'package:imposter/features/game/presentation/widgets/game_settings/game_settings_list.dart';
import 'package:imposter/features/game/presentation/widgets/game_settings/start_button.dart';

class GameSettingsView extends StatelessWidget {
  const GameSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: AppPaddings.h18,
              sliver: SliverToBoxAdapter(
                child: _GameSettingsViewBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GameSettingsViewBody extends StatelessWidget {
  const _GameSettingsViewBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.bottomPaddingH05(context),
      child: Column(
        children: [
          const CustomAppBar(),
          const GameSettingsList(),
          SizedBox(height: AppPaddings.heightH05(context)),
          StartButton(
            onTap: () async {
              context.read<GameCubit>().prepareRound();
              await context.pushNamed(AppRoutes.game);
            },
          ),
        ],
      ),
    );
  }
}
