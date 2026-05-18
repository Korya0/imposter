import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_toast.dart';
import 'package:imposter/core/presentation/widgets/show_how_to_play_sheet.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/feedback/presentation/widgets/feedback_bottom_sheet.dart';

class HomeButtonsSection extends StatelessWidget {
  const HomeButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: context.s(18),
      children: [
        _AnimatedHomeItem(
          delay: 600.ms,
          child: Row(
            spacing: context.s(8),
            children: [
              Expanded(
                child: AppButton(
                  title: AppStrings.howToPlay,
                  onTap: () => showHowToPlaySheet(context),
                ),
              ),
              Expanded(
                child: AppButton(
                  title: AppStrings.feedbackSuggestionOrComplaint,
                  onTap: () => showFeedbackBottomSheet(context),
                ),
              ),
            ],
          ),
        ),
        _AnimatedHomeItem(
          delay: 800.ms,
          child: AppButton(
            title: AppStrings.letsGo,
            onTap: () {
              unawaited(context.pushNamed(AppRoutes.topicsSelection));
            },
          ),
        ),
        _AnimatedHomeItem(
          delay: 1000.ms,
          child: ClipRect(
            child: Banner(
              message: '🔒',
              location: BannerLocation.topStart,
              color: AppColors.secondary,
              textStyle: AppTextStyles.font18W700Primary,
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
}

class _AnimatedHomeItem extends StatelessWidget {
  final Widget child;
  final Duration delay;

  const _AnimatedHomeItem({
    required this.child,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final animated = child
        .animate()
        .fadeIn(delay: delay, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad);

    return RepaintBoundary(child: animated);
  }
}
