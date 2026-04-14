import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/router/app_transitions.dart';
import 'package:imposter/features/splash/views/splash_view.dart';
import 'package:imposter/features/home/views/home_view.dart';
import 'package:imposter/features/game/views/topics_selection_view.dart';
import 'package:imposter/features/game/views/game_settings_view.dart';
import 'package:imposter/features/game/views/game_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,

  routes: [
    GoRoute(
      path: AppRoutes.splash,
      name: AppRoutes.splash,
      pageBuilder: (context, state) => AppTransitions.fade(
        context: context,
        state: state,
        child: const SplashView(),
      ),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: AppRoutes.home,
      pageBuilder: (context, state) => AppTransitions.slideFromRight(
        context: context,
        state: state,
        child: const HomeView(),
      ),
    ),
    GoRoute(
      path: AppRoutes.topicsSelection,
      name: AppRoutes.topicsSelection,
      pageBuilder: (context, state) => AppTransitions.slideFromRight(
        context: context,
        state: state,
        child: const TopicsSelectionView(),
      ),
    ),
    GoRoute(
      path: AppRoutes.gameSettings,
      name: AppRoutes.gameSettings,
      pageBuilder: (context, state) => AppTransitions.slideFromRight(
        context: context,
        state: state,
        child: const GameSettingsView(),
      ),
    ),
    GoRoute(
      path: AppRoutes.game,
      name: AppRoutes.game,
      pageBuilder: (context, state) => AppTransitions.slideFromRight(
        context: context,
        state: state,
        child: const GameView(),
      ),
    ),
  ],
  errorPageBuilder: (context, state) => AppTransitions.fade(
    context: context,
    state: state,
    child: const Scaffold(
      body: Center(
        child: Text('Error'),
      ),
    ),
  ),
);
