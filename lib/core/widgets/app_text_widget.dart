import 'package:flutter/material.dart';
import 'package:imposter/core/theme/app_text_styles.dart';

class AppTextWidget extends StatelessWidget {
  const AppTextWidget(
    this.title, {
    super.key,
    this.style,
    this.textAlign,
  });

  final String title;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style ?? AppTextStyles.font22W800Primary,
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}
