import 'package:flutter/material.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

abstract class AppPaddings {
  static const EdgeInsets h18 = EdgeInsets.symmetric(horizontal: 18);
  static const EdgeInsets h24 = EdgeInsets.symmetric(horizontal: 24);
  static const EdgeInsets h12 = EdgeInsets.symmetric(horizontal: 12);
  static const EdgeInsets all16 = EdgeInsets.all(16);
  static const EdgeInsets all20 = EdgeInsets.all(20);
  static const EdgeInsets all24 = EdgeInsets.all(24);

  static const EdgeInsets toastPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 12,
  );
  static const EdgeInsets toastMargin = EdgeInsets.symmetric(
    horizontal: 16,
  );

  static const EdgeInsets sketchyCardMargin = EdgeInsets.only(
    top: 25,
    left: 10,
    right: 10,
  );

  // Responsive Paddings & Heights
  static EdgeInsets bottomPaddingH05(BuildContext context) =>
      EdgeInsets.only(bottom: (context.height * 0.05).clamp(12, 32));

  static EdgeInsets appBarBottomPadding(BuildContext context) =>
      EdgeInsets.only(bottom: (context.height * 0.01).clamp(20, 40));

  static double heightH05(BuildContext context) =>
      (context.height * 0.05).clamp(8, 24);
  static double heightH01(BuildContext context) =>
      (context.height * 0.01).clamp(12, 32);
  static double heightH05Large(BuildContext context) =>
      (context.height * 0.05).clamp(18, 42);
  static double heightH10(BuildContext context) =>
      (context.height * 0.1).clamp(0, 100);
  static const double spacing30 = 30;
}
