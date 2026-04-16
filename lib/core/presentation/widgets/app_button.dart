import 'package:imposter/core/constants/app_paddings.dart';
import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';

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
        child: Container(
          width: width,
          height: height ?? 60,
          padding: width == null
              ? AppPaddings.h12
              : null,
          alignment: Alignment.center,
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
                  style: style ?? AppTextStyles.font45W800Secondary,
                ),
              ),
        ),
      ),
    );
  }
}
