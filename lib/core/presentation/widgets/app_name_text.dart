import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';

class AppNameText extends StatelessWidget {
  const AppNameText({
    super.key,
    this.textStyle,
  });

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return AppTextWidget(
      AppStrings.spy,
      style: textStyle ?? AppTextStyles.fontSecond60W700Primary,
    );
  }
}
