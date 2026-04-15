import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/widgets/app_button_label.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.title,
    this.onTap,
    this.style,
    this.width,
    this.height,
    this.child,
  }) : assert(
         title != null || child != null,
         'Title or child must be provided',
       );

  final String? title;
  final VoidCallback? onTap;
  final TextStyle? style;
  final double? width;
  final double? height;
  final Widget? child;

  static const double _depth = 6;

  @override
  Widget build(BuildContext context) {
    final buttonHeight = height ?? 70;

    return Semantics(
      label: title,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: RepaintBoundary(
          child: SizedBox(
            width: width ?? double.infinity,
            height: buttonHeight + _depth,
            child: Stack(
              children: [
                // Optimized Shadow layer: Using colorFilter instead of Opacity widget
                Positioned(
                  left: 0,
                  right: 0,
                  top: _depth,
                  bottom: 0,
                  child: SvgPicture.asset(
                    AppSvgs.paper,
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withValues(alpha: 0.35),
                      BlendMode.modulate,
                    ),
                  ),
                ),
                // Static Main layer
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: _depth,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        child: SvgPicture.asset(
                          AppSvgs.paper,
                          fit: BoxFit.fill,
                        ),
                      ),
                      if (child != null)
                        Positioned.fill(child: child!)
                      else
                        AppButtonLabel(title: title!, style: style),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
