import 'package:imposter/core/error/result.dart';
import 'package:imposter/features/game/domain/entities/category_entity.dart';

abstract class IGameRepository {
  Future<Result<List<CategoryEntity>>> getCategories();
}
