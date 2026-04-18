import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:imposter/features/game/data/datasources/game_local_data_source.dart';
import 'package:imposter/features/game/data/repositories/game_repository_impl.dart';
import 'package:imposter/features/game/domain/repositories/game_repository.dart';
import 'package:imposter/features/game/domain/usecases/get_categories_usecase.dart';
import 'package:imposter/features/game/domain/services/game_engine.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';
import 'package:dio/dio.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:imposter/features/feedback/data/datasources/feedback_remote_data_source.dart';
import 'package:imposter/features/feedback/data/repositories/feedback_repository_impl.dart';
import 'package:imposter/features/feedback/presentation/cubit/feedback_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> setupEssentialDI() async {
  sl
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
    ..registerLazySingleton<GameCubit>(
      () => GameCubit(sl<GetCategoriesUsecase>(), sl<GameEngine>()),
    )
    ..registerLazySingleton<FeedbackRemoteDataSource>(
      () => FeedbackRemoteDataSourceImpl(sl<Dio>()),
    )
    ..registerLazySingleton<FeedbackRepositoryImpl>(
      () => FeedbackRepositoryImpl(sl<FeedbackRemoteDataSource>()),
    )
    ..registerFactory<FeedbackCubit>(
      () => FeedbackCubit(sl<FeedbackRepositoryImpl>()),
    );
}
