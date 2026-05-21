import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
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
      height: height ?? context.s(170),
    );
  }
}
