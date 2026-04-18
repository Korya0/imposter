import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:imposter/core/constants/aoo_constants.dart';
import 'package:imposter/core/di/app_initializer.dart';
import 'package:imposter/core/di/di.dart';
import 'package:imposter/core/router/app_router.dart';
import 'package:imposter/core/theme/app_theme.dart';
import 'package:imposter/core/theme/system_ui_config.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemUiConfig.setup();
  await AppInitializer.initEssential();
  runApp(
    kIsWeb && kDebugMode
        ? DevicePreview(builder: (context) => const ImposterApp())
        : const ImposterApp(),
  );

  // Background initialization to avoid loading flickers
  unawaited(sl<GameCubit>().init());
}

class ImposterApp extends StatelessWidget {
  const ImposterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      locale: const Locale(AppConstants.ar),
      supportedLocales: const [Locale(AppConstants.ar)],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: appRouter,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => context.unFocus(),
          child: child,
        );
      },
    );
  }
}
