import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/widgets/app_button.dart';
import 'package:imposter/core/widgets/app_text_widget.dart';

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
          height: 70,
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppSvgs.play,
                height: 32,
              ),
              const SizedBox(width: 12),
              AppTextWidget(
                AppStrings.start,
                style: AppTextStyles.font30W800Background.copyWith(
                  fontSize: 50,
                ),
              ),
            ],
          ),
        )
        .animate()
        .animate(
          onPlay: (controller) => controller.repeat(reverse: true),
        )
        .scale(
          begin: const Offset(1, 1),
          end: const Offset(1.1, 1.1),
          duration: 1500.ms,
          curve: Curves.easeInOutSine,
        );
  }
}
