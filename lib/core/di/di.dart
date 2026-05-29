import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:imposter/features/game/data/datasources/game_local_data_source.dart';
import 'package:imposter/features/game/data/repositories/game_repository_impl.dart';
import 'package:imposter/features/game/domain/repositories/game_repository.dart';
import 'package:imposter/features/game/domain/usecases/get_categories_usecase.dart';
import 'package:imposter/features/game/domain/services/game_engine.dart';
import 'package:imposter/features/game/presentation/controller/game_setup_cubit/game_setup_cubit.dart';
import 'package:imposter/features/game/presentation/controller/game_session_cubit/game_session_cubit.dart';
import 'package:dio/dio.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:imposter/features/feedback/data/datasources/feedback_remote_data_source.dart';
import 'package:imposter/features/feedback/data/repositories/feedback_repo_impl.dart';
import 'package:imposter/features/feedback/data/repositories/i_feedback_repository.dart';
import 'package:imposter/features/feedback/presentation/cubit/feedback_cubit.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:imposter/core/services/config/iai_config_service.dart';
import 'package:imposter/core/services/config/firebase_ai_config_service.dart';

final GetIt sl = GetIt.instance;

Future<void> setupEssentialDI() async {
  sl
    ..registerLazySingleton<FirebaseRemoteConfig>(() => FirebaseRemoteConfig.instance)
    ..registerLazySingleton<IAIConfigService>(
      () => FirebaseAiConfigService(sl<FirebaseRemoteConfig>()),
    )
    ..registerLazySingleton<Dio>(Dio.new)
    ..registerLazySingleton<AudioPlayer>(AudioPlayer.new)
    ..registerLazySingleton<GameEngine>(GameEngine.new)
    ..registerLazySingleton<GameLocalDataSource>(GameLocalDataSourceImpl.new)
    ..registerLazySingleton<IGameRepository>(
      () => GameRepositoryImpl(localDataSource: sl<GameLocalDataSource>()),
    )
    ..registerLazySingleton<GetCategoriesUsecase>(
      () => GetCategoriesUsecase(repository: sl<IGameRepository>()),
    )
    ..registerLazySingleton<GameSetupCubit>(
      () => GameSetupCubit(sl<GetCategoriesUsecase>()),
    )
    ..registerLazySingleton<GameSessionCubit>(
      () => GameSessionCubit(sl<GameEngine>()),
    )
    ..registerLazySingleton<FeedbackRemoteDataSource>(
      () => FeedbackRemoteDataSourceImpl(sl<Dio>()),
    )
    ..registerLazySingleton<IFeedbackRepository>(
      () => FeedbackRepoImpl(sl<FeedbackRemoteDataSource>()),
    )
    ..registerFactory<FeedbackCubit>(
      () => FeedbackCubit(sl<IFeedbackRepository>()),
    );
}
