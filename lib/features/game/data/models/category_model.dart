import 'package:imposter/core/constants/app_constants.dart';
import 'package:imposter/features/game/domain/entities/category_entity.dart';

import 'word_model.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.icon,
    required List<WordModel> super.words,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json[AppConstants.idKey] as String,
      name: json[AppConstants.nameKey] as String,
      icon: json[AppConstants.iconKey] as String,
      words: (json[AppConstants.wordsKey] as List<dynamic>)
          .map(
            (wordJson) => WordModel.fromJson(wordJson as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppConstants.idKey: id,
      AppConstants.nameKey: name,
      AppConstants.iconKey: icon,
      AppConstants.wordsKey: words.map((word) => (word as WordModel).toJson()).toList(),
    };
  }
}
