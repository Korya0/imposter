import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/utils/haptic_feedback_helper.dart';

class GameFingerprintButton extends StatefulWidget {
  const GameFingerprintButton({required this.onTap, super.key});
  final VoidCallback onTap;

  @override
  State<GameFingerprintButton> createState() => _GameFingerprintButtonState();
}

class _GameFingerprintButtonState extends State<GameFingerprintButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) async {
        setState(() => _isPressed = false);
        await HapticFeedbackHelper.successPattern();
        widget.onTap();
      },
      onLongPress: () async {
        setState(() => _isPressed = false);
        await HapticFeedbackHelper.successPattern();
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      behavior: HitTestBehavior.opaque,
      child: _FingerprintContent(isPressed: _isPressed),
    );
  }
}

class _FingerprintContent extends StatelessWidget {
  const _FingerprintContent({required this.isPressed});
  final bool isPressed;

  @override
  Widget build(BuildContext context) {
    final scanColor = isPressed
        ? AppColors.primary
        : AppColors.primary.withValues(alpha: 0.8);


    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: context.p(24),
      children:  [
      AppTextWidget(
        AppStrings.scanHere,
        style: AppTextStyles.font22W400Primary,
      ),
      RepaintBoundary(
            child: Padding(
              padding: EdgeInsets.all(context.p(12)),
              child: SvgPicture.asset(
                AppAssets.fingerprintSvg,
                height: context.s(80),
                colorFilter: ColorFilter.mode(scanColor, BlendMode.srcIn),
              ),
            ),
          )
          .animate(target: isPressed ? 1 : 0)
          .scale(
            begin: const Offset(1, 1),
            end: const Offset(1.15, 1.15),
            duration: 150.ms,
          ),
    ],
    );
  }
}
