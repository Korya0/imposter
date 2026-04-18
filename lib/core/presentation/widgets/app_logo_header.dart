import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class AppLogoHeader extends StatelessWidget {
  final bool isVertical;
  final bool shouldAnimate;
  final bool showText;
  final double? logoHeight;
  final double? spacing;
  final TextStyle? textStyle;

  const AppLogoHeader({
    super.key,
    this.isVertical = true,
    this.shouldAnimate = false,
    this.showText = true,
    this.logoHeight,
    this.spacing,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveLogoHeight =
        logoHeight ??
        (isVertical
            ? (context.height * 0.23).clamp(100, 200)
            : (context.height * 0.11).clamp(80, 100));

    final effectiveSpacing =
        spacing ?? (isVertical ? (context.height * 0.05).clamp(14, 40) : 24.0);

    final children = showText
        ? (isVertical
              ? [
                  _buildText(),
                  SizedBox(height: effectiveSpacing),
                  _buildLogo(context, effectiveLogoHeight),
                ]
              : [
                  _buildText(),
                  SizedBox(width: effectiveSpacing),
                  _buildLogo(context, effectiveLogoHeight),
                ])
        : [_buildLogo(context, effectiveLogoHeight)];

    final content = isVertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: children,
          );

    return content;
  }

  Widget _buildLogo(BuildContext context, double height) {
    Widget logo = SvgPicture.asset(
      AppAssets.logoSvg,
      height: height,
    );

    if (shouldAnimate) {
      logo = logo
          .animate()
          .fadeIn(delay: 400.ms, duration: 800.ms)
          .slideY(begin: 0.2, end: 0);
      return RepaintBoundary(child: logo);
    }

    return logo;
  }

  Widget _buildText() {
    Widget text = AppTextWidget(
      AppStrings.spy,
      style: textStyle ?? AppTextStyles.ruqaa60BoldPrimary,
    );

    if (shouldAnimate) {
      text = text
          .animate()
          .fadeIn(duration: 800.ms, curve: Curves.easeOut)
          .slideY(begin: -0.2, end: 0);
      return RepaintBoundary(child: text);
    }

    return text;
  }
}
