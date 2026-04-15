import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: title,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: width ?? double.infinity,
          height: height ?? 70,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.paperWebp),
              fit: BoxFit.fill,
            ),
          ),
          child: child ?? AppButtonLabel(title: title!, style: style),
        ),
      ),
    );
  }
}
