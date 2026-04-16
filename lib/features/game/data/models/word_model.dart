import '../../../../core/constants/game_json_keys.dart';
import '../../domain/entities/word_entity.dart';

class WordModel extends WordEntity {
  WordModel({required super.id, required super.name});

  factory WordModel.fromMap(Map<String, dynamic> map) {
    return WordModel(
      id: map[GameJsonKeys.idKey] as String,
      name: map[GameJsonKeys.nameKey] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      GameJsonKeys.idKey: id,
      GameJsonKeys.nameKey: name,
    };
  }
}
