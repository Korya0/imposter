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
      id: map['id'] as String,
      name: map['name'] as String,
      icon: map['icon'] as String,
      words: (map['words'] as List<dynamic>)
          .map((word) => WordModel.fromMap(word as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'words': (words as List<WordModel>).map((word) => word.toMap()).toList(),
    };
  }
}
