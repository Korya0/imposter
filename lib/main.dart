import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:imposter/core/router/app_router.dart';
import 'package:imposter/core/theme/app_theme.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

void main() {
  runApp(
    kIsWeb && kDebugMode
        ? DevicePreview(builder: (context) => const ImposterApp())
        : const ImposterApp(),
  );
}

class ImposterApp extends StatelessWidget {
  const ImposterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
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
