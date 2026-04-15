import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/widgets/app_button.dart';
import 'package:imposter/core/widgets/app_text_widget.dart';

class GameSettingItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final String value;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const GameSettingItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.value,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppButton(
          width: 250,
          child: Padding(
            padding: AppPaddings.h18,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                AppTextWidget(
                  title,
                  style: AppTextStyles.font30W800Background,
                ),
                SvgPicture.asset(
                  iconPath,
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(
                    AppColors.background,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary, width: 0.9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                onPressed: onDecrement,
                icon: const Icon(
                  Icons.remove_sharp,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
            ),
            SizedBox(
              width: 70,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: AppTextWidget(
                  value,
                  style: AppTextStyles.font36W800Primary.copyWith(fontSize: 40),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary, width: 0.9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                onPressed: onIncrement,
                icon: const Icon(
                  Icons.add_sharp,
                  size: 28,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
