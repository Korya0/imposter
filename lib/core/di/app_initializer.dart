import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/di/di.dart';
import 'package:imposter/core/utils/app_bloc_observer.dart';
import 'package:imposter/core/utils/app_logger.dart';

class AppInitializer {
  static Future<void> initEssential() async {
    try {
      await setupEssentialDI();

      Bloc.observer = AppBlocObserver();

      AppLogger.info('Essential initialization completed successfully.');
    } on Object catch (e, stack) {
      AppLogger.error('Essential initialization failed.', e, stack);
      rethrow;
    }
  }
}
