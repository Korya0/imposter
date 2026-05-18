import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';

class ReadyPhaseWidget extends StatelessWidget {
  const ReadyPhaseWidget({
    required this.onStartTimer,
    super.key,
  });
  final VoidCallback onStartTimer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onStartTimer,
      child: Center(
        child: Column(
          spacing: AppPaddings.spacing30,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextWidget(
              AppStrings.ready,
              style: AppTextStyles.font45W700Primary,
            ),
            Container(
              padding: AppPaddings.all20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 2),
              ),
              child: SvgPicture.asset(
                AppAssets.playSvg,
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
