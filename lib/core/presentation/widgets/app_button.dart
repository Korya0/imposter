import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

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
      
        onTap: onTap != null
            ? () {
                HapticFeedback.lightImpact();
                onTap!();
              }
            : null,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: width,
          height: height ?? 60,
          padding: width == null
              ? EdgeInsets.symmetric(horizontal: context.p(12))
              : null,
          alignment: const Alignment(0, -0.40),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AppAssets.paperWebp,
              ),
              fit: BoxFit.fill,
            ),
          ),
          child:
              child ??
              FittedBox(
                fit: BoxFit.scaleDown,
                child: AppTextWidget(
                  title!,
                  style: style ?? AppTextStyles.font36W700Secondary,
                ),
              ),
        ),
      ),
    );
  }
}

