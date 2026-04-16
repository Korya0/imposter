import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/widgets/app_toast.dart';

extension BuildContextExtension on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;

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
