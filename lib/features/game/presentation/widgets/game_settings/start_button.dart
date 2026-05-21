import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class StartButton extends StatelessWidget {
  const StartButton({required this.onTap, super.key});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      width: context.w(250),
      onTap: onTap,
      child: Row(
        spacing: context.p(12),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTextWidget(
            AppStrings.start,
            style: AppTextStyles.font36W700Background,
          ),
          SvgPicture.asset(AppAssets.playSvg, height: context.s(24)),
        ],
      ),
    );
  }
}
