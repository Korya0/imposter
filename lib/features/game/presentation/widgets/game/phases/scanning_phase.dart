import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';

class ScanningPhaseWidget extends StatelessWidget {
  const ScanningPhaseWidget({
    required this.playerNumber,
    super.key,
  });
  final int playerNumber;

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
                playerNumber.toString(),
                style: AppTextStyles.font32W400Primary,
              ),
              AppTextWidget(
                AppStrings.player,
                style: AppTextStyles.font32W400Primary,
              ),
            ],
          ), 
        ),
      ],
    );
  }
}
