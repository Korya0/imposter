import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_text_styles.dart';

class GameSummaryView extends StatelessWidget {
  final String secretWord;
  final int playersCount;
  final int spiesCount;
  final Duration duration;
  final VoidCallback onAnotherRound;
  final VoidCallback onFinish;

  const GameSummaryView({
    super.key,
    required this.secretWord,
    required this.playersCount,
    required this.spiesCount,
    required this.duration,
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
          _buildInfoRow(AppStrings.numberOfPlayers, playersCount.toString()),
          const SizedBox(height: 12),
          _buildInfoRow(AppStrings.numberOfSpies, spiesCount.toString()),
          const SizedBox(height: 12),
          _buildInfoRow(
            AppStrings.numberOfMinutes,
            '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
          ),
          const SizedBox(height: 40),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12,
              children: [
                AppTextWidget(
                  AppStrings.anotherRound,
                  style: AppTextStyles.ruqaa28W400White,
                ),
                InkWell(
                  onTap: onAnotherRound,
                  child: Container(
                    padding: AppPaddings.all16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 1.5),
                    ),
                    child: SvgPicture.asset(
                      AppAssets.redoSvg,
                      width: 40,
                      height: 40,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
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
