import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/widgets/app_text_widget.dart';

class HomeAppNameAndLogo extends StatelessWidget {
  const HomeAppNameAndLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: (context.height * 0.05).clamp(14, 40)),
        AppTextWidget(
          AppStrings.spy,
          style: AppTextStyles.font50BoldPrimary,
        ),
        SizedBox(height: (context.height * 0.05).clamp(14, 40)),
        SvgPicture.asset(
          AppSvgs.logo,
          height: (context.height * 0.23).clamp(100, 200),
        ),
      ],
    );
  }
}
