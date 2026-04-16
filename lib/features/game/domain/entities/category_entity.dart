import 'package:imposter/features/game/domain/entities/word_entity.dart';

class CategoryEntity {
  final String id;
  final String name;
  final String icon;
  final List<WordEntity> words;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.icon,
    required this.words,
  });
}
