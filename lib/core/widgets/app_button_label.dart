import 'package:flutter/material.dart';
import 'package:imposter/core/theme/app_text_styles.dart';

class AppButtonLabel extends StatelessWidget {
  const AppButtonLabel({
    super.key,
    required this.title,
    this.style,
  });

  final String title;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 4),
      child: Center(
        child: Transform.translate(
          offset: const Offset(0, -12),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: (style ?? AppTextStyles.font34BoldSecondary).copyWith(
                leadingDistribution: TextLeadingDistribution.even,
              ),
              textAlign: TextAlign.center,
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
