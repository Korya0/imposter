import '../../../../core/constants/game_json_keys.dart';
import '../../domain/entities/word_entity.dart';

class WordModel {
  final String id;
  final String name;

  WordModel({required this.id, required this.name});

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

  WordEntity toEntity() {
    return WordEntity(
      id: id,
      name: name,
    );
  }
}
