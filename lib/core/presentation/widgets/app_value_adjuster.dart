import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';

class AppValueAdjuster extends StatelessWidget {
  const AppValueAdjuster({
    required this.value,
    super.key,
    this.onIncrement,
    this.onDecrement,
    this.width = 70,
  });
  final String value;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildControlButton(
          icon: Icons.add_sharp,
          onPressed: onIncrement,
        ),
        SizedBox(
          width: width,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: AppTextWidget(
              value,
              style: AppTextStyles.font40W700Primary,
            ),
          ),
        ),
        _buildControlButton(
          icon: Icons.remove_sharp,
          onPressed: onDecrement,
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary, width: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 28,
        ),
      ),
    );
  }
}
