import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_text_styles.dart';

class AppValueAdjuster extends StatelessWidget {
  final String value;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final double? width;

  const AppValueAdjuster({
    super.key,
    required this.value,
    this.onIncrement,
    this.onDecrement,
    this.width = 70,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildControlButton(
          icon: Icons.remove_sharp,
          onPressed: onDecrement,
        ),
        SizedBox(
          width: width,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: AppTextWidget(
              value,
              style: AppTextStyles.font40W800Primary,
            ),
          ),
        ),
        _buildControlButton(
          icon: Icons.add_sharp,
          onPressed: onIncrement,
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
