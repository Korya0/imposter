import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/di/di.dart';
import 'package:imposter/core/presentation/views/app_error_view.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';
import 'package:imposter/features/game/presentation/views/game_settings_view.dart';
import 'package:imposter/features/game/presentation/views/game_view.dart';
import 'package:imposter/features/game/presentation/views/topics_selection_view.dart';
import 'package:imposter/features/home/presentation/views/home_view.dart';
import 'package:imposter/features/splash/splash_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      name: AppRoutes.splash,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: AppRoutes.home,
      builder: (context, state) => const HomeView(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        final cubit = sl<GameCubit>();
        unawaited(cubit.init());
        return BlocProvider.value(
          value: cubit,
          child: child,
        );
      },
      routes: [
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
    ),
  ],
  errorBuilder: (context, state) => const AppErrorView(),
);
