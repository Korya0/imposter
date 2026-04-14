import 'dart:async';

import 'package:flutter/material.dart';
import 'package:imposter/core/widgets/app_snack_bar.dart';

abstract class AppSnackBarHelper {
  static OverlayEntry? _current;
  static Completer<void>? _dismissCompleter;

  static Future<void> show(
    BuildContext context, {
    required String message,
    AppSnackBarPosition position = AppSnackBarPosition.top,
    Duration duration = const Duration(seconds: 3),
  }) async {
    if (_current != null) return;

    if (!context.mounted) return;

    final overlay = Overlay.of(context);
    final completer = Completer<void>();
    _dismissCompleter = completer;

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => AppSnackBarContent(
        message: message,
        position: position,
        onDismiss: () {
          entry.remove();
          if (_current == entry) _current = null;
          if (!completer.isCompleted) completer.complete();
        },
      ),
    );

    _current = entry;
    overlay.insert(entry);

    unawaited(Future<void>.delayed(duration, () {
      if (_current == entry) unawaited(_dismissCurrent());
    }));
  }

  static Future<void> _dismissCurrent() async {
    final entry = _current;
    _current = null;

    if (entry != null && entry.mounted) {
      entry.remove();
    }

    if (_dismissCompleter != null && !_dismissCompleter!.isCompleted) {
      _dismissCompleter!.complete();
    }

    await Future<void>.delayed(const Duration(milliseconds: 400));
  }
}
