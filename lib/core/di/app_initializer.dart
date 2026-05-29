import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:imposter/core/di/di.dart';
import 'package:imposter/core/style/theme/system_ui_config.dart';
import 'package:imposter/core/utils/app_bloc_observer.dart';
import 'package:imposter/core/utils/app_logger.dart';
import 'package:imposter/firebase_options.dart';

class AppInitializer {
  static Future<void> initEssential() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await SystemUiConfig.setup();
      await setupEssentialDI();

      Bloc.observer = AppBlocObserver();

      // Configure global crash handlers for production
      if (!kDebugMode && !kIsWeb) {
        
        FlutterError.onError = (errorDetails) {
          FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
        };
        PlatformDispatcher.instance.onError = (error, stack) {
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
          return true;
        };
      }

      AppLogger.info('Essential initialization completed successfully.');
    } on Object catch (e, stack) {
      AppLogger.error('Essential initialization failed.', e, stack);
      rethrow;
    }
  }
}
