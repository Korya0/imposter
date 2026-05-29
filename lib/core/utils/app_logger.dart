import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    _log('🛠️ DEBUG', message, error, stackTrace);
  }

  static void info(String message) {
    _log('ℹ️ INFO', message);
  }

  static void warning(String message, [Object? error, StackTrace? stackTrace]) {
    _log('⚠️ WARNING', message, error, stackTrace);
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _log('❌ ERROR', message, error, stackTrace);

    if (!kDebugMode && !kIsWeb) {
      if (_shouldIgnoreError(error)) return;

      unawaited(
        FirebaseCrashlytics.instance.recordError(
          error ?? message,
          stackTrace,
          reason: message,
        ),
      );
    }
  }

  static bool _shouldIgnoreError(Object? error) {
    if (error == null) return false;
    final errStr = error.toString().toLowerCase();
    return errStr.contains('socketexception') ||
        errStr.contains('network_error') ||
        errStr.contains('connection failed') ||
        errStr.contains('connection timeout') ||
        errStr.contains('cancel') ||
        errStr.contains('handshake') ||
        errStr.contains('host lookup');
  }

  static void _log(
    String level,
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
  
    if (!kDebugMode) return;

    final timestamp = DateTime.now().toLocal().toString().split('.').first;

    debugPrint('[$timestamp] [$level] $message');
    if (error != null) debugPrint('   ↳ Error: $error');
    if (stackTrace != null) debugPrint('   ↳ StackTrace: $stackTrace');
  }
}
