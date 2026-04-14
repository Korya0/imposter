import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/widgets/app_text_widget.dart';

class HomeAppNameAndLogo extends StatelessWidget {
  const HomeAppNameAndLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: (context.height * 0.05).clamp(14, 40)),
        AppTextWidget(
          title: AppStrings.spy,
          style: AppTextStyles.font50BoldPrimary,
        ).animate().fadeIn(duration: 250.ms),
        SizedBox(height: (context.height * 0.05).clamp(14, 40)),
        SvgPicture.asset(
              AppSvgs.logo,
              height: (context.height * 0.23).clamp(100, 200),
            )
            .animate()
            .fadeIn(duration: 250.ms, delay: 100.ms)
            .scale(
              begin: const Offset(0.85, 0.85),
              duration: 250.ms,
              delay: 100.ms,
              curve: Curves.easeOutCubic,
            ),
      ],
    );
  }
}
