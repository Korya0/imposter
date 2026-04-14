import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;

  void unFocus() {
    final currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.unfocus();
    }
  }

  bool get isIOS => Theme.of(this).platform == TargetPlatform.iOS;
  bool get isAndroid => Theme.of(this).platform == TargetPlatform.android;
  bool get isWeb => kIsWeb;
}
