sealed class GameSessionState {
  const GameSessionState();
}

class GameSessionInitial extends GameSessionState {
  const GameSessionInitial();
}

class GameSessionScanning extends GameSessionState {
  const GameSessionScanning({
    required this.currentPlayerIndex,
    required this.secretWord,
    required this.spyIndices,
  });
  final int currentPlayerIndex;
  final String secretWord;
  final List<int> spyIndices;
}

class GameSessionRevealing extends GameSessionState {
  const GameSessionRevealing({
    required this.currentPlayerIndex,
    required this.secretWord,
    required this.spyIndices,
    required this.isSpy,
  });
  final int currentPlayerIndex;
  final String secretWord;
  final List<int> spyIndices;
  final bool isSpy;
}

class GameSessionReady extends GameSessionState {
  const GameSessionReady({
    required this.secretWord,
    required this.spyIndices,
  });
  final String secretWord;
  final List<int> spyIndices;
}

class GameSessionTimer extends GameSessionState {
  const GameSessionTimer({
    required this.secretWord,
    required this.spyIndices,
    required this.durationMinutes,
  });
  final String secretWord;
  final List<int> spyIndices;
  final int durationMinutes;
}

class GameSessionSummary extends GameSessionState {
  const GameSessionSummary({
    required this.secretWord,
    required this.playerCount,
    required this.spyCount,
    required this.durationMinutes,
  });
  final String secretWord;
  final int playerCount;
  final int spyCount;
  final int durationMinutes;
}
