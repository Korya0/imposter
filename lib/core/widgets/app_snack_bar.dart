import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/widgets/app_text_widget.dart';

enum AppSnackBarPosition { top, bottom }

class AppSnackBarContent extends StatelessWidget {
  const AppSnackBarContent({
    super.key,
    required this.message,
    required this.position,
    required this.onDismiss,
  });

  final String message;
  final AppSnackBarPosition position;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final isTop = position == AppSnackBarPosition.top;

    return Positioned(
      top: isTop ? 0 : null,
      bottom: isTop ? null : 0,
      left: 0,
      right: 0,
      child: SafeArea(
        bottom: !isTop,
        top: isTop,
        child: Padding(
          padding: AppPaddings.all16,
          child: _AppSnackBarCard(
            message: message,
            onClose: onDismiss,
          ),
        ),
      ),
    );
  }
}

class _AppSnackBarCard extends StatelessWidget {
  const _AppSnackBarCard({
    required this.message,
    required this.onClose,
  });

  final String message;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.primary, width: 0.8),
        ),
        child: Row(
          spacing: 8,
          children: [
            Expanded(
              child: AppTextWidget(
                title: message,
                style: AppTextStyles.font18W800Primary,
              ),
            ),
            GestureDetector(
              onTap: onClose,
              behavior: HitTestBehavior.opaque,
              child: const Icon(
                Icons.close_rounded,
                color: AppColors.primary,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
