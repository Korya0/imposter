import 'package:flutter/material.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class AppGap extends StatelessWidget {
  final double size;
  final bool isVertical;

  const AppGap(
    this.size, {
    super.key,
    this.isVertical = true,
  });

  @override
  Widget build(BuildContext context) {
    final responsiveSize = context.p(size);
    return SizedBox(
      height: isVertical ? responsiveSize : null,
      width: isVertical ? null : responsiveSize,
    );
  }
}
