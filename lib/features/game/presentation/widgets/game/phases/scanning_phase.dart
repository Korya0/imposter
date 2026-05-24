import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_fingerprint_button.dart';

class ScanningPhaseWidget extends StatelessWidget {
  const ScanningPhaseWidget({
    required this.playerName,
    required this.onScanTap,
    super.key,
  });
  final String playerName;
  final VoidCallback onScanTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const AppGap(0),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextWidget(
              AppStrings.scanHere,
              style: AppTextStyles.font28W400Primary,
            ),
            AppTextWidget(
              playerName,
              style: AppTextStyles.font28W400Primary,
              maxLines: 1,                         
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        const AppGap(0),
        GameFingerprintButton(onTap: onScanTap),
      ],
    );
  }
}
