import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    this.height,
    super.key,
  });

  final double? height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.logoSvg,
      height: height ?? context.s(200),
    );
  }
}

class AppNameText extends StatelessWidget {
  const AppNameText({
    super.key,
    this.textStyle,
  });

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return AppTextWidget(
      AppStrings.spy,
      style: textStyle ?? AppTextStyles.font60W700Primary,
    );
  }
}
