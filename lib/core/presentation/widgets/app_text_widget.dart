import 'package:flutter/material.dart';
import 'package:imposter/core/theme/app_text_styles.dart';

class AppTextWidget extends StatelessWidget {
  const AppTextWidget(
    this.title, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String title;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style ?? AppTextStyles.font22W800Primary,
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
