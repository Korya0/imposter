import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/widgets/app_text_widget.dart';

class AppNameAndLogo extends StatelessWidget {
  const AppNameAndLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 24,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppAssets.logoSvg,
          height: (context.height * 0.11).clamp(80, 100),
        ),
        AppTextWidget(
          AppStrings.spy,
          style: AppTextStyles.ruqaa60BoldPrimary,
        ),
      ],
    );
  }
}
