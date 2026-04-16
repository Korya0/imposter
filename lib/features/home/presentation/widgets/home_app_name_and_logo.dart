import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';

class HomeAppNameAndLogo extends StatelessWidget {
  const HomeAppNameAndLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextWidget(
              AppStrings.spy,
              style: AppTextStyles.ruqaa60BoldPrimary,
            )
            .animate()
            .fadeIn(duration: 800.ms, curve: Curves.easeOut)
            .slideY(begin: -0.2, end: 0),

        SizedBox(height: (context.height * 0.05).clamp(14, 40)),

        SvgPicture.asset(
              AppAssets.logoSvg,
              height: (context.height * 0.23).clamp(100, 200),
            )
            .animate()
            .fadeIn(
              delay: 400.ms,
              duration: 800.ms,
            )
            .slideY(begin: 0.2, end: 0)
            .shimmer(
              color: AppColors.background,
              delay: 2.seconds,
              duration: 1500.ms,
            ),
      ],
    );
  }
}
