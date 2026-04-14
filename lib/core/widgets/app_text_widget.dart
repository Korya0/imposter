import 'package:flutter/material.dart';
import 'package:imposter/core/theme/app_text_styles.dart';

class AppTextWidget extends StatelessWidget {
  const AppTextWidget({
    super.key,
    required this.title,
    this.style,
  });

  final String title;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: (style ?? AppTextStyles.font24BoldSecondary).copyWith(
        leadingDistribution: TextLeadingDistribution.even,
      ),
      textAlign: TextAlign.center,
      // this is for the text height important for AppButton Dont Edit
      textHeightBehavior: const TextHeightBehavior(
        applyHeightToFirstAscent: false,
      ),
    );
  }
}
