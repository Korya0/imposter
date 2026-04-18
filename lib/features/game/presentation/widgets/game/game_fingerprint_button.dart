import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/utils/haptic_feedback_helper.dart';

class GameFingerprintButton extends StatefulWidget {
  final VoidCallback onTap;
  const GameFingerprintButton({super.key, required this.onTap});

  @override
  State<GameFingerprintButton> createState() => _GameFingerprintButtonState();
}

class _GameFingerprintButtonState extends State<GameFingerprintButton> {
  bool _isPressed = false;

  Future<void> _handleTap() async {
    setState(() {
      _isPressed = true;
    });
    await HapticFeedbackHelper.heavy();
    await Future<void>.delayed(150.ms);
    if (mounted) {
      setState(() {
        _isPressed = false;
      });
      widget.onTap();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 24,
        children: [
          AppTextWidget(
            AppStrings.scanHere,
            style: AppTextStyles.font40W800Primary,
          ),
          SvgPicture.asset(
                AppAssets.fingerprintSvg,
                height: 120,
                colorFilter: ColorFilter.mode(
                  _isPressed ? AppColors.green : AppColors.primary,
                  BlendMode.srcIn,
                ),
              )
              .animate(target: _isPressed ? 1 : 0)
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.1, 1.1),
                duration: 80.ms,
              ),
        ],
      ),
    );
  }
}
