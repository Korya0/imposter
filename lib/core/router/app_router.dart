import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/router/app_transitions.dart';
import 'package:imposter/features/game/views/game_settings_view.dart';
import 'package:imposter/features/game/views/game_view.dart';
import 'package:imposter/features/game/views/topics_selection_view.dart';
import 'package:imposter/features/home/views/home_view.dart';
import 'package:imposter/features/splash/views/splash_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      name: AppRoutes.splash,
      pageBuilder: (context, state) => AppTransitions.fade(
        state: state,
        child: const SplashView(),
      ),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: AppRoutes.home,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: AppRoutes.topicsSelection,
      name: AppRoutes.topicsSelection,
      builder: (context, state) => const TopicsSelectionView(),
    ),
    GoRoute(
      path: AppRoutes.gameSettings,
      name: AppRoutes.gameSettings,
      builder: (context, state) => const GameSettingsView(),
    ),
    GoRoute(
      path: AppRoutes.game,
      name: AppRoutes.game,
      builder: (context, state) => const GameView(),
    ),
  ],
  errorBuilder: (context, state) => const Scaffold(
    body: Center(child: Text('Error')),
  ),
);
