import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class AppButton extends StatefulWidget {
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
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (widget.onTap != null) {
      setState(() {
        _isPressed = true;
      });
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onTap != null) {
      setState(() {
        _isPressed = false;
      });
    }
  }

  void _handleTapCancel() {
    if (widget.onTap != null) {
      setState(() {
        _isPressed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.title,
      button: true,
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.onTap != null
            ? () {
                HapticFeedback.lightImpact();
                widget.onTap!();
              }
            : null,
        behavior: HitTestBehavior.opaque,
        child: AnimatedScale(
          scale: _isPressed ? 0.95 : 1.0,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutCubic,
          child: Container(
            width: widget.width,
            height: widget.height ?? 60,
            padding: widget.width == null
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
                widget.child ??
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: AppTextWidget(
                    widget.title!,
                    style: widget.style ?? AppTextStyles.font36W700Secondary,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}

