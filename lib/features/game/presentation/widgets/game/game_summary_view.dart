import 'package:imposter/core/constants/app_paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';

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
    return Column(
      children: [
        const SizedBox(height: 24),
        AppTextWidget(
          AppStrings.summary,
          style: AppTextStyles.ruqaa45BoldPrimary,
        ),
        const SizedBox(height: 48),
        _buildInfoRow(AppStrings.word, secretWord),
        const SizedBox(height: 24),
        _buildInfoRow(AppStrings.numberOfPlayers, playersCount.toString()),
        const SizedBox(height: 24),
        _buildInfoRow(AppStrings.numberOfSpies, spiesCount.toString()),
        const SizedBox(height: 24),
        _buildInfoRow(
          AppStrings.numberOfMinutes,
          '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
        ),
        const Spacer(),
        Column(
          children: [
            InkWell(
              onTap: onAnotherRound,
              child: Container(
                padding: AppPaddings.all16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: SvgPicture.asset(
                  AppAssets.redoSvg,
                  width: 40,
                  height: 40,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            AppTextWidget(
              AppStrings.anotherRound,
              style: AppTextStyles.ruqaa28W400White,
            ),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: AppPaddings.h24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTextWidget(
            value,
            style: AppTextStyles.ruqaa28W400Primary,
          ),
          AppTextWidget(
            ': $label',
            style: AppTextStyles.ruqaa28W400White,
          ),
        ],
      ),
    );
  }
}
