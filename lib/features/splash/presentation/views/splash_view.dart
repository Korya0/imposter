import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/presentation/widgets/app_logo.dart';
import 'package:imposter/core/presentation/widgets/app_name_text.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

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
      context.goNamed(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Row(
              spacing: context.p(24),
              mainAxisAlignment: MainAxisAlignment.center,
              children: [  
                const AppNameText(),
                AppLogo(
                  height: context.s(100),
                ), 
              ],
            ).animate().fadeIn(
              duration: 1500.ms,
              curve: Curves.easeInOut,
            ),
      ),
    );
  }
}
