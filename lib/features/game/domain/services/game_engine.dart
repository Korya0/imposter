import 'dart:math';

import 'package:imposter/features/game/domain/entities/category_entity.dart';
import 'package:imposter/features/game/domain/entities/word_entity.dart';

class GameSetup {
  GameSetup({
    required this.secretWord,
    required this.spyIndices,
  });
  final WordEntity secretWord;
  final List<int> spyIndices;
}

class GameEngine {
  GameEngine({Random? random}) : _random = random ?? Random();
  final Random _random;

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
