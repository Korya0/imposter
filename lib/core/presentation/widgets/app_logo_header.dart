import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class AppLogoHeader extends StatelessWidget {
  const AppLogoHeader({
    super.key,
    this.isVertical = true,
    this.showText = true,
    this.logoHeight,
    this.spacing,
    this.textStyle,
  });

  final bool isVertical;
  final bool showText;
  final double? logoHeight;
  final double? spacing;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final effectiveLogoHeight =
        logoHeight ?? (isVertical ? context.s(160) : context.s(90));

    final effectiveSpacing =
        spacing ?? (isVertical ? context.p(18) : context.p(24));

    final children = [
      if (showText) ...[
        _Text(textStyle: textStyle),
        SizedBox(
          height: isVertical ? effectiveSpacing : 0,
          width: isVertical ? 0 : effectiveSpacing,
        ),
      ],
      _Logo(height: effectiveLogoHeight),
    ];

    return isVertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: children,
          );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SvgPicture.asset(
        AppAssets.logoSvg,
        height: height,
      ),
    );
  }
}

class _Text extends StatelessWidget {
  const _Text({
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
