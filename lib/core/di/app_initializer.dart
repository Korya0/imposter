import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/di/di.dart';
import 'package:imposter/core/theme/system_ui_config.dart';
import 'package:imposter/core/utils/app_bloc_observer.dart';
import 'package:imposter/core/utils/app_logger.dart';

class AppInitializer {
  static Future<void> initEssential() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await SystemUiConfig.setup();

      await setupEssentialDI();

      await Future.wait<void>([
        vg.loadPicture(const SvgAssetLoader(AppSvgs.paper), null),
        vg.loadPicture(const SvgAssetLoader(AppSvgs.logo), null),
      ]);

      Bloc.observer = AppBlocObserver();

      AppLogger.info('Essential initialization completed successfully.');
    } on Object catch (e, stack) {
      AppLogger.error('Essential initialization failed.', e, stack);
      rethrow;
    }
  }

  static Future<void> initBackground() async {
    await setupNonEssentialDI();

    AppLogger.info('Background initialization completed successfully.');
  }
}
