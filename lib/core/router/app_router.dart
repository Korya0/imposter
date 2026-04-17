import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/di/di.dart';
import 'package:imposter/core/presentation/views/app_error_view.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/router/app_transitions.dart';
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
      pageBuilder: (context, state) => AppTransitions.fade(
        state: state,
        child: const SplashView(),
        context: context,
      ),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: AppRoutes.home,
      pageBuilder: (context, state) => AppTransitions.slideFromRight(
        state: state,
        child: const HomeView(),
        context: context,
      ),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider(
          create: (context) {
            final cubit = sl<GameCubit>();
            unawaited(cubit.init());
            return cubit;
          },
          child: child,
        );
      },
      routes: [
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
    ),
  ],
  errorBuilder: (context, state) => const AppErrorView(),
);
