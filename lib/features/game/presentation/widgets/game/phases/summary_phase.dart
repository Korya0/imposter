import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_text_styles.dart';

class SummaryPhaseWidget extends StatelessWidget {
  final String secretWord;
  final int playerCount;
  final int spyCount;
  final int durationMinutes;
  final VoidCallback onAnotherRound;
  final VoidCallback onFinish;

  const SummaryPhaseWidget({
    super.key,
    required this.secretWord,
    required this.playerCount,
    required this.spyCount,
    required this.durationMinutes,
    required this.onAnotherRound,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppTextWidget(
            AppStrings.summary,
            style: AppTextStyles.font34W800Primary,
          ),
          const SizedBox(height: 6),
          _buildInfoRow(AppStrings.word, secretWord),
          const SizedBox(height: 12),
          _buildInfoRow(AppStrings.numberOfPlayers, playerCount.toString()),
          const SizedBox(height: 12),
          _buildInfoRow(AppStrings.numberOfSpies, spyCount.toString()),
          const SizedBox(height: 12),
          _buildInfoRow(
            AppStrings.numberOfMinutes,
            '$durationMinutes:00',
          ),
          const SizedBox(height: 40),
          Center(
            child: GestureDetector(
              onTap: onAnotherRound,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: AppPaddings.all16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 16,
                  children: [
                    AppTextWidget(
                      AppStrings.anotherRound,
                      style: AppTextStyles.ruqaa28W400White,
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 1.5),
                      ),
                      child: SvgPicture.asset(
                        AppAssets.redoSvg,
                        width: 32,
                        height: 32,
                        colorFilter: const ColorFilter.mode(
                          AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: AppPaddings.h24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AppTextWidget(
            value,
            style: AppTextStyles.font28W800Primary.copyWith(
              color: AppColors.white.withValues(alpha: 0.8),
            ),
          ),
          AppTextWidget(
            ': $label',
            style: AppTextStyles.font28W800Primary,
          ),
        ],
      ),
    );
  }
}
