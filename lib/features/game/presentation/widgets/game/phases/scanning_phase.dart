import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
        Column(
          children: [
            const AppTextWidget(
              AppStrings.scanHere,
            ),
            AppTextWidget(
              playerName,
              style: AppTextStyles.font36W700Primary,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        )
            .animate()
            .fadeIn(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOut,
            )
            .slideY(
              begin: -0.15,
              end: 0,
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutQuad,
            ),
        const AppGap(0),
        // Hold-to-scan Fingerprint button with direct stateless callback and delay
        GameFingerprintButton(
          onTap: () {
            Future.delayed(const Duration(milliseconds: 400), onScanTap);
          },
        )
            .animate()
            .fadeIn(
              delay: const Duration(milliseconds: 150),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
            )
            .scale(
              begin: const Offset(0.85, 0.85),
              end: const Offset(1, 1),
              delay: const Duration(milliseconds: 150),
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeOutBack,
            ),
      ],
    );
  }
}
