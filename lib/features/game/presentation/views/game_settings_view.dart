import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/presentation/widgets/custom_app_bar.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';
import 'package:imposter/features/game/presentation/widgets/game_settings/game_settings_list.dart';
import 'package:imposter/features/game/presentation/widgets/game_settings/start_button.dart';

class GameSettingsView extends StatelessWidget {
  const GameSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'الإعدادات'),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: context.p(18)),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const GameSettingsList(),
                  SizedBox(height: context.p(24)),
                  Padding(
                    padding: EdgeInsets.only(bottom: context.p(24)),
                    child: Center(
                      child: StartButton(
                        onTap: () async {
                          context.read<GameCubit>().prepareRound();
                          await context.pushNamed(AppRoutes.game);
                        },
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
