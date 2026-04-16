import 'package:imposter/core/constants/app_paddings.dart';
import 'package:flutter/material.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:toastification/toastification.dart';

enum ToastPosition { top, bottom }

class AppToast {
  static DateTime? _lastToastTime;
  static String? _lastMessage;

  static void show(
    BuildContext context,
    String message, {
    ToastPosition position = ToastPosition.top,
    int? seconds,
  }) {
    final now = DateTime.now();

    // De-bounce logic: Prevent identical message within 2 seconds
    if (_lastToastTime != null &&
        _lastMessage == message &&
        now.difference(_lastToastTime!) < const Duration(seconds: 2)) {
      return;
    }
    _lastToastTime = now;
    _lastMessage = message;

    toastification
      ..dismissAll()
      ..show(
        context: context,
        style: ToastificationStyle.minimal,
        direction: TextDirection.rtl,
        title: AppTextWidget(
          message,
          style: AppTextStyles.font22W800Primary,
        ),
        alignment: position == ToastPosition.top
            ? Alignment.topCenter
            : Alignment.bottomCenter,
        autoCloseDuration: Duration(seconds: seconds ?? 2),
        borderRadius: BorderRadius.circular(16),
        primaryColor: AppColors.primary,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.white,
        padding: AppPaddings.toastPadding,
        margin: AppPaddings.toastMargin,
        showProgressBar: false,
        closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
        dragToClose: true,
        applyBlurEffect: false,

        borderSide: BorderSide(color: AppColors.primary.withValues(alpha: 0.3)),
      );
  }
}

