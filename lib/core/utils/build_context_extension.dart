import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/widgets/app_toast.dart';

extension BuildContextExtension on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;

  bool get isWeb => kIsWeb;

  // h: Scales heights/lengths (vertical dimensions)
  double h(double value) =>
      (value * (height / 812)).clamp(value * 0.6, value * 1.5);

  // w: Scales widths/breadths (horizontal dimensions)
  double w(double value) =>
      (value * (width / 375)).clamp(value * 0.8, value * 1.3);

  // s: Scales element sizes (icons, sized custom shapes)
  double s(double value) =>
      (value * (width / 375)).clamp(value * 0.8, value * 1.3);

  // p: Scales spacings (paddings, margins, gaps, SizedBox spacing)
  double p(double value) =>
      (value * (width / 375)).clamp(value * 0.8, value * 1.3);

  // f: Scales font sizes (text size)
  double f(double value) =>
      (value * (width / 375)).clamp(value * 0.8, value * 1.3);

  void showAppToast(
    String message, {
    ToastPosition position = ToastPosition.top,
    int? seconds,
  }) {
    AppToast.show(this, message, position: position, seconds: seconds);
  }

  void unFocus() {
    final currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.unfocus();
    }
  }
}
