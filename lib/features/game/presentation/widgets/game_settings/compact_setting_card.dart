import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/presentation/widgets/app_value_adjuster.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class CompactSettingCard extends StatelessWidget {
  const CompactSettingCard({
    required this.iconPath,
    required this.title,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    super.key,
  });
  final String iconPath;
  final String title;
  final String value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.p(8),
        vertical: context.p(10),
      ),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(context.p(16)),
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: context.p(8),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: context.p(6),
            children: [
              SvgPicture.asset(
                iconPath,
                width: context.s(20),
                height: context.s(20),
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              AppTextWidget(title, style: AppTextStyles.font16W700Primary),
            ],
          ),
          AppValueAdjuster(
            value: value,
            width: context.w(30),
            onIncrement: onIncrement,
            onDecrement: onDecrement,
          ),
        ],
      ),
    );
  }
}
