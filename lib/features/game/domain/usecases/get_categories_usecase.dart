import 'package:imposter/core/error/result.dart';
import 'package:imposter/features/game/domain/entities/category_entity.dart';
import 'package:imposter/features/game/domain/repositories/game_repository.dart';

class GetCategoriesUsecase {
  GetCategoriesUsecase({required this.repository});
  final IGameRepository repository;

  Future<Result<List<CategoryEntity>>> call() async {
    return repository.getCategories();
  }
}
