import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/widgets/custom_app_bar.dart';
import 'package:imposter/features/game/presentation/widgets/game_settings/game_setting_item.dart';
import 'package:imposter/features/game/presentation/widgets/game_settings/start_button.dart';
import 'package:go_router/go_router.dart';

class GameSettingsViewBody extends StatelessWidget {
  const GameSettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: (context.height * 0.05).clamp(12, 32),
      ),
      child: Column(
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

          SizedBox(height: (context.height * 0.05).clamp(12, 32)),

          const GameSettingItem(
                iconPath: AppSvgs.spy,
                title: AppStrings.numberOfSpies,
                value: '1',
              )
              .animate()
              .fadeIn(delay: 250.ms, duration: 600.ms)
              .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),

          SizedBox(height: (context.height * 0.01).clamp(12, 32)),

          const GameSettingItem(
                iconPath: AppSvgs.timeOclock,
                title: AppStrings.numberOfMinutes,
                value: '5',
              )
              .animate()
              .fadeIn(delay: 400.ms, duration: 600.ms)
              .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),

          SizedBox(height: (context.height * 0.05).clamp(18, 42)),

          StartButton(
            onTap: () => context.pushNamed(AppRoutes.game),
          ),
        ],
      ),
    );
  }
}
