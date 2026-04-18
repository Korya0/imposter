import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_toast.dart';
import 'package:imposter/core/presentation/widgets/show_how_to_play_sheet.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_text_styles.dart';

class HomeButtonsSection extends StatelessWidget {
  const HomeButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 18,
      children: [
        _buildAnimatedItem(
          delay: 600.ms,
          child: Row(
            spacing: 8,
            children: [
              Expanded(
                child: AppButton(
                  title: AppStrings.howToPlay,
                  onTap: () => showHowToPlaySheet(context),
                ),
              ),
              Expanded(
                child: AppButton(
                  title: AppStrings.drawer,
                  onTap: () => context.pushNamed(AppRoutes.drawer),
                ),
              ),
            ],
          ),
        ),
        _buildAnimatedItem(
          delay: 800.ms,
          shouldPulse: true,
          child: AppButton(
            title: AppStrings.letsGo,
            onTap: () {
              unawaited(context.pushNamed(AppRoutes.topicsSelection));
            },
          ),
        ),
        _buildAnimatedItem(
          delay: 1000.ms,
          child: ClipRect(
            child: Banner(
              message: '🔒',
              location: BannerLocation.topStart,
              color: AppColors.secondary,
              textStyle: AppTextStyles.font22W800Primary,
              child: AppButton(
                width: double.infinity,
                title: AppStrings.online,
                onTap: () => AppToast.show(context, AppStrings.comingSoon),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedItem({
    required Widget child,
    required Duration delay,
    bool shouldPulse = false,
  }) {
    var animated = child
        .animate()
        .fadeIn(delay: delay, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad);

    if (shouldPulse) {
      animated = animated
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scale(
            begin: const Offset(1, 1),
            end: const Offset(1.06, 1.06),
            duration: 1500.ms,
            curve: Curves.easeInOutSine,
          );
    }

    return animated;
  }
}
