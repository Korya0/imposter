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
    this.width,
    this.height,
    this.style,
    this.child,
  }) : assert(
         title != null || child != null,
         'Title or child must be provided',
       );

  final String? title;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final TextStyle? style;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null
          ? () {
              HapticFeedback.lightImpact();
              onTap!();
            }
          : null,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: width,
        height: height ?? context.h(65),
        // for responsiveness 
        constraints: BoxConstraints(
          maxWidth: width ?? 400,
        ),
        padding: width == null
            ? EdgeInsets.symmetric(horizontal: context.p(12))
            : null,
        alignment: const Alignment(0, 0.10),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.paperWebp),
            fit: BoxFit.fill,
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child:
              child ??
              AppTextWidget(
                title!,
                style: style ?? AppTextStyles.font26W700Secondary,
              ),
        ),
      ),
    );
  }
}
