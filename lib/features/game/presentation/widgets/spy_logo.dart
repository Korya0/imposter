import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class SpyLogo extends StatelessWidget {
  const SpyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppSvgs.logo,
      height: (context.height * 0.23).clamp(100, 200),
    )
        .animate()
        .fadeIn(delay: 400.ms, duration: 800.ms)
        .slideY(begin: 0.2, end: 0)
        .shimmer(
          color: AppColors.background,
          delay: 2.seconds,
          duration: 1500.ms,
        );
  }
}
