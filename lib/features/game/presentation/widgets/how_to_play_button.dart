import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/presentation/widgets/app_toast.dart';
import 'package:imposter/core/theme/app_text_styles.dart';

class HowToPlayIconButton extends StatelessWidget {
  const HowToPlayIconButton({
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
                size: 36,
              ),
            ),
            if (showText)
              SvgPicture.asset(
                AppAssets.arrowLineLongSvg,
                width: 40,
              ),
            if (showText)
              AppTextWidget(
                AppStrings.howToPlay,
                style: AppTextStyles.font22W200Primary,
              ),
          ],
        ),
      ),
    );
  }
}
