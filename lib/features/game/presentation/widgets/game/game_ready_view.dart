import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/widgets/app_text_widget.dart';

class GameReadyView extends StatelessWidget {
  final VoidCallback onStartTimer;
  const GameReadyView({super.key, required this.onStartTimer});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onStartTimer,
      child: Center(
        child: Column(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextWidget(
              AppStrings.ready,
              style: AppTextStyles.ruqaa45BoldPrimary,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 2),
              ),
              child: SvgPicture.asset(
                AppSvgs.play,
                height: 60,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ).animate().fadeIn().scale(),
    );
  }
}
