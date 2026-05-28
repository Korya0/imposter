import 'package:imposter/core/error/exceptions.dart';
import 'package:imposter/core/utils/app_logger.dart';
import 'package:imposter/features/game/data/datasources/static_topics_data.dart';
import 'package:imposter/features/game/data/models/category_model.dart';

abstract class GameLocalDataSource {
  Future<List<CategoryModel>> getCategories();
}

class GameLocalDataSourceImpl implements GameLocalDataSource {
  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      AppLogger.info('Loading categories from hardcoded static Dart data');
      final categories = StaticTopicsData.categories;
      AppLogger.info('Successfully loaded ${categories.length} categories');
      return categories;
    } on Exception catch (e, stackTrace) {
      AppLogger.error('Failed to load categories', e, stackTrace);
      throw AssetException(
        'Failed to load categories from static data: $e',
        stackTrace,
      );
    }
  }
}
