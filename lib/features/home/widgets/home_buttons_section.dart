import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/widgets/app_button.dart';
import 'package:imposter/core/widgets/app_toast.dart';

class HomeButtonsSection extends StatelessWidget {
  const HomeButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 18,
      children: [
        Row(
              spacing: 8,
              children: [
                Expanded(
                  child: AppButton(
                    title: AppStrings.howToPlay,
                    onTap: () => AppToast.show(
                      context,
                      AppStrings.comingSoon,
                    ),
                  ),
                ),
                Expanded(
                  child: AppButton(
                    title: AppStrings.drawer,
                    onTap: () => AppToast.show(
                      context,
                      AppStrings.comingSoon,
                    ),
                  ),
                ),
              ],
            )
            .animate()
            .fadeIn(delay: 600.ms, duration: 600.ms)
            .slideY(
              begin: 0.2,
              end: 0,
            ),
        AppButton(
              title: AppStrings.letsGo,
              onTap: () => context.pushNamed(AppRoutes.topicsSelection),
            )
            .animate()
            .fadeIn(delay: 800.ms, duration: 600.ms)
            .slideY(begin: 0.2, end: 0)
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .scale(
              begin: const Offset(1, 1),
              end: const Offset(1.03, 1.03),
              duration: 1500.ms,
              curve: Curves.easeInOutSine,
            ),
        ClipRect(
              child: Banner(
                message: '🔒',
                location: BannerLocation.topStart,
                color: AppColors.background,
                textStyle: const TextStyle(fontSize: 22),
                child: AppButton(
                  width: double.infinity,
                  title: AppStrings.online,
                  onTap: () => AppToast.show(
                    context,
                    AppStrings.comingSoon,
                  ),
                ),
              ),
            )
            .animate()
            .fadeIn(delay: 1000.ms, duration: 600.ms)
            .slideY(
              begin: 0.2,
              end: 0,
            ),
      ],
    );
  }
}
