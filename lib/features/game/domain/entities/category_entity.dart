import 'package:imposter/features/game/domain/entities/word_entity.dart';

class CategoryEntity {
  CategoryEntity({
    required this.id,
    required this.name,
    required this.icon,
    required this.words,
  });
  final String id;
  final String name;
  final String icon;
  final List<WordEntity> words;
}
