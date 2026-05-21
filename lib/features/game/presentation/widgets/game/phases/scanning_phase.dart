import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_fingerprint_button.dart';

class ScanningPhaseWidget extends StatelessWidget {
  const ScanningPhaseWidget({
    required this.playerNumber,
    required this.onScanTap,
    super.key,
  });
  final int playerNumber;
  final VoidCallback onScanTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        const AppGap(0),
        GameFingerprintButton(onTap: onScanTap),
      ],
    );
  }
}
