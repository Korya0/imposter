import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/widgets/app_text_widget.dart';

/// The default styled text label used inside [AppButton].
/// Can be reused when passing a custom [child] to [AppButton]
/// to maintain the same visual text style and centering.
class AppButtonLabel extends StatelessWidget {
  const AppButtonLabel({
    super.key,
    required this.title,
    this.style,
  });

  final String title;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 4),
      child: Center(
        child: Transform.translate(
          // Lifts Arabic text to visual center, compensating for font baseline gap
          offset: const Offset(0, -12),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: AppTextWidget(
              title: title,
              style: style ?? AppTextStyles.font34BoldSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: title,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: width ?? double.infinity,
          height: height ?? 70,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  AppSvgs.paper,
                  fit: BoxFit.cover,
                ),
              ),

              // Use custom child or fall back to the default AppButtonLabel
              if (child != null)
                Positioned.fill(child: child!)
              else
                AppButtonLabel(title: title!, style: style),
            ],
          ),
        ),
      ),
    );
  }
}
