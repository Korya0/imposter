import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/widgets/app_button.dart';
import 'package:imposter/core/widgets/app_text_widget.dart';

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
          style: AppTextStyles.font22W200Primary,
        ),
        const SizedBox(height: 48),
        _buildInfoRow(AppStrings.word, secretWord),
        const SizedBox(height: 16),
        _buildInfoRow(AppStrings.numberOfPlayers, playersCount.toString()),
        const SizedBox(height: 16),
        _buildInfoRow(AppStrings.numberOfSpies, spiesCount.toString()),
        const SizedBox(height: 16),
        _buildInfoRow(
          AppStrings.numberOfMinutes,
          '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                InkWell(
                  onTap: onAnotherRound,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white),
                    ),
                    child: SvgPicture.asset(
                      AppSvgs.redo,
                      width: 32,
                      height: 32,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                AppTextWidget(
                  AppStrings.anotherRound,
                  style: AppTextStyles.font22W200Primary.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 48),
        AppButton(
          width: 250,
          height: (context.height * 0.1).clamp(50, 70),
          title: AppStrings.finishGame,
          onTap: onFinish,
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTextWidget(
            '$label :',
            style: AppTextStyles.font22W200Primary.copyWith(color: Colors.white),
          ),
          AppTextWidget(
            value,
            style: AppTextStyles.font22W200Primary,
          ),
        ],
      ),
    );
  }
}
