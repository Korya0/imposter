import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class GameSettingHeader extends StatelessWidget {
  const GameSettingHeader({
    required this.iconAsset,
    required this.title,
    super.key,
  });

  final String iconAsset;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: context.p(8),
      children: [
        SvgPicture.asset(
          iconAsset,
          width: context.s(22),
          height: context.s(22),
          colorFilter: const ColorFilter.mode(
            AppColors.primary,
            BlendMode.srcIn,
          ),
        ),
        AppTextWidget(
          title,
          style: AppTextStyles.font18W700Primary,
        ),
      ],
    );
  }
}
