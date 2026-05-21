import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/painters/sketchy_circle_painter.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class ReadyPhaseWidget extends StatelessWidget {
  const ReadyPhaseWidget({required this.onStartTimer, super.key});
  final VoidCallback onStartTimer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onStartTimer,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: Column(
          spacing: context.p(30),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextWidget(
              AppStrings.ready,
              style: AppTextStyles.font45W700Primary,
            ),
            CustomPaint(
              painter: const SketchyCirclePainter(color: AppColors.primary),
              child: Padding(
                padding: EdgeInsets.all(context.p(24)),
                child: SvgPicture.asset(
                  AppAssets.playSvg,
                  height: context.s(60),
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ).animate().fadeIn().scale(),
    );
  }
}
