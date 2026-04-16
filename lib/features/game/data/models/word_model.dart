import 'package:imposter/core/constants/app_constants.dart';
import 'package:imposter/features/game/domain/entities/word_entity.dart';

class WordModel extends WordEntity {
  const WordModel({
    required super.id,
    required super.name,
  });

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
      id: json[AppConstants.idKey] as String,
      name: json[AppConstants.nameKey] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppConstants.idKey: id,
      AppConstants.nameKey: name,
    };
  }
}
