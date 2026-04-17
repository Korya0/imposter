import 'dart:math';

import 'package:imposter/features/game/domain/entities/category_entity.dart';
import 'package:imposter/features/game/domain/entities/word_entity.dart';

class GameSetup {
  final WordEntity secretWord;
  final List<int> spyIndices;

  GameSetup({
    required this.secretWord,
    required this.spyIndices,
  });
}

class GameEngine {
  final Random _random;

  GameEngine({Random? random}) : _random = random ?? Random();

  GameSetup prepareRound({
    required CategoryEntity category,
    required int playerCount,
    required int spyCount,
  }) {
    final word = category.words[_random.nextInt(category.words.length)];

    final playerIndices = List.generate(playerCount, (index) => index)
      ..shuffle(_random);
    final spies = playerIndices.take(spyCount).toList();

    return GameSetup(
      secretWord: word,
      spyIndices: spies,
    );
  }
}
