import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
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
        title: AppTextWidget(
          message,
          style: AppTextStyles.font16W700Primary,
        ),
        alignment: position == ToastPosition.top
            ? Alignment.topCenter
            : Alignment.bottomCenter,
        autoCloseDuration: Duration(seconds: seconds ?? 2),
        borderRadius: BorderRadius.circular(context.p(16)),
        primaryColor: AppColors.primary,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.white,
        padding: EdgeInsets.symmetric(
          horizontal: context.p(20),
          vertical: context.p(12),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: context.p(16),
        ),
        showProgressBar: false,
        closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
        dragToClose: true,
        applyBlurEffect: false,

        borderSide: BorderSide(color: AppColors.primary.withValues(alpha: 0.3)),
      );
  }
}
