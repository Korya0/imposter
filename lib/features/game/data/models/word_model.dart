import '../../domain/entities/word_entity.dart';

class WordModel extends WordEntity {
  WordModel({required super.id, required super.name});

  factory WordModel.fromMap(Map<String, dynamic> map) {
    return WordModel(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
