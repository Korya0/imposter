import 'package:flutter/material.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

abstract class AppPadding {
  static EdgeInsets viewH18(BuildContext ctx) => EdgeInsets.symmetric(
    horizontal:  ctx.p(18),
  );
}
