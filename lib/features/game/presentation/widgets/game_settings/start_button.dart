import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';

class StartButton extends StatelessWidget {
  const StartButton({
    super.key,
    required this.onTap,
  });
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return AppButton(
          width: 250,
          height: (context.height * 0.1).clamp(50, 70),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextWidget(
                AppStrings.start,
                style: AppTextStyles.font45W800Background,
              ),
              const SizedBox(width: 12),
              SvgPicture.asset(
                AppAssets.playSvg,
                height: (context.height * 0.04).clamp(28, 30),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 600.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0);
  }
}
