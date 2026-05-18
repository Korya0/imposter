import 'package:imposter/core/constants/game_json_keys.dart';
import 'package:imposter/features/game/domain/entities/category_entity.dart';
import 'package:imposter/features/game/data/models/word_model.dart';

class CategoryModel {
  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.words,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map[GameJsonKeys.idKey] as String,
      name: map[GameJsonKeys.nameKey] as String,
      icon: map[GameJsonKeys.iconKey] as String,
      words: (map[GameJsonKeys.wordsKey] as List<dynamic>)
          .map((word) => WordModel.fromMap(word as Map<String, dynamic>))
          .toList(),
    );
  }
  final String id;
  final String name;
  final String icon;
  final List<WordModel> words;

  Map<String, dynamic> toMap() {
    return {
      GameJsonKeys.idKey: id,
      GameJsonKeys.nameKey: name,
      GameJsonKeys.iconKey: icon,
      GameJsonKeys.wordsKey: words.map((word) => word.toMap()).toList(),
    };
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      icon: icon,
      words: words.map((word) => word.toEntity()).toList(),
    );
  }
}
