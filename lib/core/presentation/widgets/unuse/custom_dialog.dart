import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    required this.child,
    super.key,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.insetPadding,
    this.useGlassmorphism = false,
    this.borderColor,
    this.borderWidth,
    this.showShadow = true,
  });

  final Widget child;
  final Color? backgroundColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsets? insetPadding;
  final bool useGlassmorphism;
  final Color? borderColor;
  final double? borderWidth;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColors.secondaryBackground;
    final effectiveBorderRadius = borderRadius ?? context.p(16);
    final effectivePadding = padding ?? EdgeInsets.all(context.p(24));
    final effectiveInsetPadding = insetPadding ?? EdgeInsets.symmetric(
      horizontal: context.w(40),
      vertical: context.h(24),
    );
    final effectiveBorderWidth = borderWidth ?? context.w(1);

    final dialogContent = Container(
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: useGlassmorphism ? bgColor.withValues(alpha: 0.95) : bgColor,
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        border: borderColor != null ? Border.all(color: borderColor!, width: effectiveBorderWidth) : null,
        boxShadow: showShadow ? [
          BoxShadow(
            color: AppColors.background.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ] : null,
      ),
      child: child,
    );

    final dialog = Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: effectiveInsetPadding,
      child: dialogContent,
    );

    return useGlassmorphism
        ? BackdropFilter(filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8), child: dialog)
        : dialog;
  }
}

Future<T?> showCustomDialog<T>({
  required BuildContext context,
  required Widget child,
  Color? backgroundColor,
  double? borderRadius,
  EdgeInsetsGeometry? padding,
  EdgeInsets? insetPadding,
  bool useGlassmorphism = false,
  Color? borderColor,
  double? borderWidth,
  bool showShadow = true,
  bool barrierDismissible = true,
  Color? barrierColor,
}) {
  final effectiveBarrierColor = barrierColor ?? AppColors.background.withValues(alpha: 0.54);
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: effectiveBarrierColor,
    builder: (context) => Material(
      color: Colors.transparent,
      child: CustomDialog(
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        padding: padding,
        insetPadding: insetPadding,
        useGlassmorphism: useGlassmorphism,
        borderColor: borderColor,
        borderWidth: borderWidth,
        showShadow: showShadow,
        child: child,
      ),
    ),
  );
}
