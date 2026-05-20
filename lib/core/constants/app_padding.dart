import 'package:flutter/material.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

abstract class AppPadding {
  static EdgeInsets viewH18(BuildContext ctx) => EdgeInsets.symmetric(
    horizontal: ctx.isLandscape ? ctx.p(28) : ctx.p(18),
  );
}
