import '../../../../core/constants/game_json_keys.dart';
import '../../domain/entities/category_entity.dart';
import 'word_model.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.id,
    required super.name,
    required super.icon,
    required List<WordModel> super.words,
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

  Map<String, dynamic> toMap() {
    return {
      GameJsonKeys.idKey: id,
      GameJsonKeys.nameKey: name,
      GameJsonKeys.iconKey: icon,
      GameJsonKeys.wordsKey: (words as List<WordModel>).map((word) => word.toMap()).toList(),
    };
  }
}
