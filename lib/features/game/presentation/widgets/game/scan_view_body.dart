import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/utils/haptic_feedback_helper.dart';
import 'package:imposter/core/widgets/app_text_widget.dart';

class ScanViewBody extends StatefulWidget {
  final VoidCallback onScanComplete;
  const ScanViewBody({super.key, required this.onScanComplete});

  @override
  State<ScanViewBody> createState() => _ScanViewBodyState();
}

class _ScanViewBodyState extends State<ScanViewBody> {
  bool _isPressed = false;

  Future<void> _handleTap() async {
    setState(() {
      _isPressed = true;
    });
    await HapticFeedbackHelper.heavy();
    await Future<void>.delayed(500.ms);
    widget.onScanComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: (context.height * 0.1).clamp(12, 50),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  '1',
                  style: AppTextStyles.ruqaa32W400Primary,
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: _handleTap,
            behavior: HitTestBehavior.opaque,

            child: Padding(
              // to easy clic
              padding: const EdgeInsets.symmetric(
                horizontal: 72,
              ),
              child: Column(
                spacing: 40,
                children: [
                  AppTextWidget(
                    AppStrings.scanHere,
                    style: AppTextStyles.ruqaa32W400Primary,
                  ),
                  SvgPicture.asset(
                        AppSvgs.fingerprint,
                        height: 100,
                        colorFilter: ColorFilter.mode(
                          _isPressed ? AppColors.green : AppColors.primary,
                          BlendMode.srcIn,
                        ),
                      )
                      .animate(target: _isPressed ? 1 : 0)
                      .scale(
                        begin: const Offset(1, 1),
                        end: const Offset(1.2, 1.2),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
