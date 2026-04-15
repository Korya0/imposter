import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/utils/app_snack_bar_helper.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/widgets/app_button.dart';

class HomeButtonsSection extends StatelessWidget {
  const HomeButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonHeight = (context.height * 0.08).clamp(60, 90);
    return Column(
      spacing: 18,
      children: [
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: AppButton(
                height: buttonHeight.toDouble(),
                title: AppStrings.howToPlay,
                onTap: () => AppSnackBarHelper.show(
                  context,
                  message: AppStrings.comingSoon,
                ),
              ),
            ),
            Expanded(
              child: AppButton(
                height: buttonHeight.toDouble(),
                title: AppStrings.drawer,
                onTap: () => AppSnackBarHelper.show(
                  context,
                  message: AppStrings.comingSoon,
                ),
              ),
            ),
          ],
        ),
        AppButton(
          height: buttonHeight.toDouble(),
          title: AppStrings.letsGo,
          onTap: () => AppSnackBarHelper.show(
            context,
            message: AppStrings.comingSoon,
          ),
        ),
        ClipRect(
          child: Banner(
            message: '🔒',
            location: BannerLocation.topStart,
            color: AppColors.background,
            textStyle: const TextStyle(fontSize: 22),
            child: AppButton(
              height: buttonHeight.toDouble(),
              title: AppStrings.online,
              onTap: () => AppSnackBarHelper.show(
                context,
                message: AppStrings.comingSoon,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
