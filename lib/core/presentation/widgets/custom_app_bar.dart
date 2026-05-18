import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.title,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: context.p(20),
              left: context.p(10),
              right: context.p(10),
            ),
            child: SizedBox(
              height: 50,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 1. Perfectly Centered Title
                  if (title != null)
                    Center(
                      child: Text(
                        title!,
                        style: AppTextStyles.font24W700Primary,
                        textAlign: TextAlign.center,
                      ),
                    ),

                  // 2. Tactile Minimalist Back Icon Button (Primary Color)
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: _BackButton(
                      onTap: () => context.pop(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(
          begin: -0.15,
          end: 0,
          duration: 450.ms,
          curve: Curves.easeOutQuad,
        );
  }
}

class _BackButton extends StatefulWidget {
  const _BackButton({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_BackButton> createState() => _BackButtonState();
}

class _BackButtonState extends State<_BackButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        HapticFeedback.lightImpact();
        widget.onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _isPressed ? 0.85 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutCubic,
        child: Padding(
          padding: EdgeInsets.all(context.p(8)),
          child: SvgPicture.asset(
            AppAssets.backIconSvg,
            height: 28,
            colorFilter: const ColorFilter.mode(
              AppColors.primary,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
