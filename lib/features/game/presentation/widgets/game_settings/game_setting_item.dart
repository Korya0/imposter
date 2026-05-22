import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/presentation/widgets/app_value_adjuster.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class GameSettingItem extends StatelessWidget {
  const GameSettingItem({
    required this.iconPath,
    required this.title,
    required this.value,
    super.key,
    this.isReadOnly = false,
    this.onIncrement,
    this.onDecrement,
  });
  final String iconPath;
  final String title;
  final String value;
  final bool isReadOnly;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: context.p(16),
      mainAxisSize: MainAxisSize.min,
      children: [
        _GameSettingHeader(iconPath: iconPath, title: title),
        if (!isReadOnly) ...[
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

class _GameSettingHeader extends StatelessWidget {
  const _GameSettingHeader({
    required this.iconPath,
    required this.title,
  });
  final String iconPath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: context.p(12),
      mainAxisAlignment: .center,
      children: [
        SvgPicture.asset(
          iconPath,
          width: context.s(28),
          height: context.s(28),
          colorFilter: const ColorFilter.mode(
            AppColors.primary,
            BlendMode.srcIn,
          ),
        ),

        AppTextWidget(
          title,
          style: AppTextStyles.font24W700Primary,
        ),
      ],
    );
  }
}
