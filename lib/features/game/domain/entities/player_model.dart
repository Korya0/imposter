import 'player_role.dart';

class PlayerModel {
  final int playerIndex;
  final PlayerRole role;
  final bool hasScanned;

  const PlayerModel({
    required this.playerIndex,
    required this.role,
    this.hasScanned = false,
  });

  PlayerModel copyWith({
    int? playerIndex,
    PlayerRole? role,
    bool? hasScanned,
  }) {
    return PlayerModel(
      playerIndex: playerIndex ?? this.playerIndex,
      role: role ?? this.role,
      hasScanned: hasScanned ?? this.hasScanned,
    );
  }
}
