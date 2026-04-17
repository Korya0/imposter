import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';

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

    final children = [
      _buildLogo(context, effectiveLogoHeight),
      if (showText) ...[
        if (isVertical)
          SizedBox(height: effectiveSpacing)
        else
          SizedBox(width: effectiveSpacing),
        _buildText(),
      ],
    ];

    final orderedChildren = showText
        ? (isVertical
            ? [children[2], children[1], children[0]]
            : [children[0], children[1], children[2]])
        : [children[0]];

    final content = isVertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: orderedChildren,
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: orderedChildren,
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
          .slideY(begin: 0.2, end: 0)
          .shimmer(
            color: AppColors.background,
            delay: 2.seconds,
            duration: 1500.ms,
          );
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
    }

    return text;
  }
}
