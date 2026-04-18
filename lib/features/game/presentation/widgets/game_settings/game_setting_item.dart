import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/presentation/widgets/app_value_adjuster.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class GameSettingItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final String value;
  final bool isReadOnly;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const GameSettingItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.value,
    this.isReadOnly = false,
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
          height: (context.height * 0.08).clamp(40, 70),
          child: Padding(
            padding: AppPaddings.h18,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(
                    AppColors.background,
                    BlendMode.srcIn,
                  ),
                ),
                AppTextWidget(
                  title,
                  style: AppTextStyles.font30W800Background,
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
        if (!isReadOnly) ...[
          SizedBox(height: (context.height * 0.02).clamp(6, 12)),
          AppValueAdjuster(
            value: value,
            onIncrement: onIncrement,
            onDecrement: onDecrement,
          ),
        ],
      ],
    );
  }
}
