import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_fonts.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/widgets/app_text_widget.dart';
import 'package:imposter/core/widgets/app_toast.dart';

class HowToPlayButton extends StatelessWidget {
  const HowToPlayButton({
    super.key,
    this.showText = true,
  });
  final bool showText;
  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: AppStrings.howToPlay,
      child: GestureDetector(
        onTap: () => AppToast.show(context, AppStrings.comingSoon),
        behavior: HitTestBehavior.opaque,
        child: Row(
          spacing: showText ? 8 : 0,
          children: [
            Transform.flip(
              flipX: true,
              child: const Icon(
                Icons.help_sharp,
                color: AppColors.primary,
                size: 36,
              ),
            ),
            if (showText)
              SvgPicture.asset(
                AppSvgs.arrowLineLong,
                width: 40,
              ),
            if (showText)
              AppTextWidget(
                AppStrings.howToPlay,
                style: AppTextStyles.font22W800Primary.copyWith(
                  fontSize: 22,
                  fontWeight: LateefWeight.w200.weight,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
