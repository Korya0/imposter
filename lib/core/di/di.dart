import 'dart:async';

import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> setupEssentialDI() async {
  //sl.registerLazySingleton<IGameRepository>(() => GameRepositoryImpl());
}

Future<void> setupNonEssentialDI() async {}
