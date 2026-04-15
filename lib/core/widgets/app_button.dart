import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/widgets/app_button_label.dart';

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

  static const double _depth = 6;
  static const Duration _duration = Duration(milliseconds: 80);

  @override
  Widget build(BuildContext context) {
    final buttonHeight = widget.height ?? 70;

    return Semantics(
      label: widget.title,
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: SizedBox(
          width: widget.width ?? double.infinity,
          height: buttonHeight + _depth,
          child: Stack(
            children: [
              // Shadow layer — static at bottom, always visible
              Positioned(
                left: 0,
                right: 0,
                top: _depth,
                bottom: 0,
                child: Opacity(
                  opacity: 0.35,
                  child: SvgPicture.asset(AppSvgs.paper, fit: BoxFit.fill),
                ),
              ),
              // Main layer — SVG + content, shifts down on press
              AnimatedPositioned(
                duration: _duration,
                curve: Curves.easeOut,
                left: 0,
                right: 0,
                top: _isPressed ? _depth : 0,
                bottom: _isPressed ? 0 : _depth,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: SvgPicture.asset(AppSvgs.paper, fit: BoxFit.fill),
                    ),
                    if (widget.child != null)
                      Positioned.fill(child: widget.child!)
                    else
                      AppButtonLabel(title: widget.title!, style: widget.style),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
