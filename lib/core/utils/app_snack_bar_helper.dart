import 'package:flutter/material.dart';
import 'package:imposter/core/widgets/app_snack_bar.dart';

class AppSnackBarHelper {
  static OverlayEntry? _current;

  static Future<void> show(
    BuildContext context, {
    required String message,
    AppSnackBarPosition position = AppSnackBarPosition.top,
    Duration duration = const Duration(seconds: 3),
  }) async {
    if (_current != null) return;

    if (!context.mounted) return;

    final entry = OverlayEntry(
      builder: (_) => AppSnackBarContent(
        message: message,
        position: position,
        onDismiss: () {
          _current?.remove();
          _current = null;
        },
      ),
    );

    _current = entry;
    Overlay.of(context).insert(entry);

    await Future<void>.delayed(duration);
    if (_current == entry) {
      _current?.remove();
      _current = null;
    }
  }
}
