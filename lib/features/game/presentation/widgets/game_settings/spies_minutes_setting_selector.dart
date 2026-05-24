import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/painters/sketchy_input_painter.dart';
import 'package:imposter/core/presentation/widgets/app_divider.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/presentation/controller/game_setup_cubit/game_setup_cubit.dart';
import 'package:imposter/features/game/presentation/controller/game_setup_cubit/game_setup_state.dart';

class SpiesMinutesSettingSelector extends StatelessWidget {
  const SpiesMinutesSettingSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: SpiesSettingSelector(),
          ),
          RotatedBox(
            quarterTurns: 1,
            child: AppDivider(),
          ),
          Expanded(
            child: MinutesSettingSelector(),
          ),
        ],
      ),
    );
  }
}

class SpiesSettingSelector extends StatelessWidget {
  const SpiesSettingSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameSetupCubit>();
    return BlocSelector<GameSetupCubit, GameSetupState, (int, int)>(
      selector: (state) => (state.spyCount, state.playerCount),
      builder: (context, data) {
        final spyCount = data.$1;
        final playerCount = data.$2;

        return Column(
          mainAxisSize: MainAxisSize.min,
          spacing: context.p(8),
          children: [
            // Top: Icon + Title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: context.p(8),
              children: [
                SvgPicture.asset(
                  AppAssets.spySvg,
                  width: context.s(18),
                  height: context.s(18),
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
                AppTextWidget(
                  AppStrings.numberOfSpies,
                  style: AppTextStyles.font18W400Primary,
                ),
              ],
            ),

            // Bottom: Sleek Wobbly Pill Adjuster
            SizedBox(
              width: context.w(130),
              height: context.h(46),
              child: CustomPaint(
                painter: SketchyInputPainter(
                  color: AppColors.primary,
                  fillColor: AppColors.secondaryBackground,
                  strokeWidth: 1.8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Decrement Button
                    CompactPillButton(
                      icon: Icons.remove_sharp,
                      onPressed: spyCount > 1 ? cubit.decrementSpies : null,
                    ),

                    // Central Numeric Value
                    AppTextWidget(
                      spyCount.toString(),
                      style: AppTextStyles.font24W700Primary,
                    ),

                    // Increment Button
                    CompactPillButton(
                      icon: Icons.add_sharp,
                      onPressed: spyCount < playerCount ~/ 2
                          ? cubit.incrementSpies
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CompactPillButton extends StatelessWidget {
  const CompactPillButton({
    required this.icon,
    required this.onPressed,
    super.key,
  });
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;
    final activeColor = isEnabled
        ? AppColors.primary
        : AppColors.primary.withValues(alpha: 0.3);

    return GestureDetector(
      onTap: isEnabled
          ? () {
              HapticFeedback.lightImpact();
              onPressed!();
            }
          : null,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: context.w(38),
        height: double.infinity,
        child: Icon(
          icon,
          color: activeColor,
          size: context.s(18),
        ),
      ),
    );
  }
}

class MinutesSettingSelector extends StatelessWidget {
  const MinutesSettingSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameSetupCubit>();
    return BlocSelector<GameSetupCubit, GameSetupState, int>(
      selector: (state) => state.durationMinutes,
      builder: (context, durationMinutes) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          spacing: context.p(8),
          children: [
            // Top: Icon + Title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: context.p(8),
              children: [
                SvgPicture.asset(
                  AppAssets.timeOclockSvg,
                  width: context.s(18),
                  height: context.s(18),
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
                AppTextWidget(
                  AppStrings.numberOfMinutes,
                  style: AppTextStyles.font18W400Primary,
                ),
              ],
            ),

            // Bottom: Sleek Wobbly Pill Adjuster
            SizedBox(
              width: context.w(130),
              height: context.h(46),
              child: CustomPaint(
                painter: SketchyInputPainter(
                  color: AppColors.primary,
                  fillColor: AppColors.secondaryBackground,
                  strokeWidth: 1.8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Decrement Button
                    CompactPillButton(
                      icon: Icons.remove_sharp,
                      onPressed: durationMinutes > 1
                          ? cubit.decrementMinutes
                          : null,
                    ),

                    // Central Numeric Value
                    AppTextWidget(
                      durationMinutes.toString(),
                      style: AppTextStyles.font24W700Primary,
                    ),

                    // Increment Button
                    CompactPillButton(
                      icon: Icons.add_sharp,
                      onPressed: durationMinutes < 30
                          ? cubit.incrementMinutes
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
