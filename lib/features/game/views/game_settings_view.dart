import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/widgets/app_toast.dart';
import 'package:imposter/core/widgets/custom_app_bar.dart';
import 'package:imposter/features/game/widgets/game_setting_item.dart';
import 'package:imposter/features/game/widgets/start_button.dart';

class GameSettingsView extends StatelessWidget {
  const GameSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPaddings.h18,
          child: SingleChildScrollView(
            child: _GameSettingsView(),
          ),
        ),
      ),
    );
  }
}

class _GameSettingsView extends StatelessWidget {
  const _GameSettingsView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(),

        const GameSettingItem(
              iconPath: AppSvgs.peopleGroup,
              title: AppStrings.numberOfPlayers,
              value: '4',
            )
            .animate()
            .fadeIn(delay: 100.ms, duration: 600.ms)
            .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),

        const SizedBox(height: 16),

        const GameSettingItem(
              iconPath: AppSvgs.spy,
              title: AppStrings.numberOfSpies,
              value: '1',
            )
            .animate()
            .fadeIn(delay: 250.ms, duration: 600.ms)
            .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),

        const SizedBox(height: 16),

        const GameSettingItem(
              iconPath: AppSvgs.timeOclock,
              title: AppStrings.numberOfMinutes,
              value: '5',
            )
            .animate()
            .fadeIn(delay: 400.ms, duration: 600.ms)
            .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),

        const SizedBox(height: 32),

        StartButton(
          onTap: () => AppToast.show(context, AppStrings.comingSoon),
        ),

        const SizedBox(height: 30),
      ],
    );
  }
}
