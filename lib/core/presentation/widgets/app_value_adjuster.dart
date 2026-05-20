import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/presentation/widgets/tactile_sketchy_icon_button.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';

class AppValueAdjuster extends StatelessWidget {
  const AppValueAdjuster({
    required this.value,
    super.key,
    this.onIncrement,
    this.onDecrement,
    this.width = 70,
    this.textColor,
    this.buttonColor,
  });
  final String value;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final double? width;
  final Color? textColor;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    final activeTextColor = textColor ?? AppColors.primary;
    final activeBtnColor = buttonColor ?? AppColors.primary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TactileSketchyIconButton(
          icon: Icons.add_sharp,
          color: activeBtnColor,
          onPressed: onIncrement,
        ),
        SizedBox(
          width: width,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: AppTextWidget(
              value,
              style: AppTextStyles.font40W700Primary.copyWith(
                color: activeTextColor,
              ),
            ),
          ),
        ),
        TactileSketchyIconButton(
          icon: Icons.remove_sharp,
          color: activeBtnColor,
          onPressed: onDecrement,
        ),
      ],
    );
  }
}
