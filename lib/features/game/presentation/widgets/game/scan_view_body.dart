import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/widgets/app_text_widget.dart';

class ScanViewBody extends StatelessWidget {
  const ScanViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextWidget(
                AppStrings.player,
                style: AppTextStyles.ruqaa32W400Primary,
              ),
              AppTextWidget(
                '1', // TODO: Binding
                style: AppTextStyles.ruqaa32W400Primary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
