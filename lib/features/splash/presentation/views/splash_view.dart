import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/di/app_initializer.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/features/splash/presentation/widgets/app_name_and_logo.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_initialize());
    });
  }

  Future<void> _initialize() async {
    await Future<void>.delayed(
      const Duration(seconds: 2),
    );

    if (mounted) {
      context.go(AppRoutes.home);
      unawaited(AppInitializer.initBackground());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const AppNameAndLogo().animate().fadeIn(
          duration: 2200.ms,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }
}
