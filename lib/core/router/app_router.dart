import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/di/di.dart';
import 'package:imposter/core/presentation/views/app_error_view.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/features/feedback/presentation/views/feedback_view.dart';
import 'package:imposter/features/game/presentation/controller/game_session_cubit/game_session_cubit.dart';
import 'package:imposter/features/game/presentation/controller/game_setup_cubit/game_setup_cubit.dart';
import 'package:imposter/features/game/presentation/views/game_settings_view.dart';
import 'package:imposter/features/game/presentation/views/game_view.dart';
import 'package:imposter/features/game/presentation/views/topics_selection_view.dart';
import 'package:imposter/features/home/presentation/views/home_view.dart';
import 'package:imposter/features/how_to_play/presentation/views/how_to_play_view.dart';
import 'package:imposter/features/splash/presentation/views/splash_view.dart';

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
    GoRoute(
      path: AppRoutes.feedback,
      name: AppRoutes.feedback,
      builder: (context, state) => const FeedbackView(),
    ),
    GoRoute(
      path: AppRoutes.howToPlay,
      name: AppRoutes.howToPlay,
      builder: (context, state) => const HowToPlayView(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        final setupCubit = sl<GameSetupCubit>();
        unawaited(setupCubit.init());
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: setupCubit),
            BlocProvider.value(value: sl<GameSessionCubit>()),
          ],
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
