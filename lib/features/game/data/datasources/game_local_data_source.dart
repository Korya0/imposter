import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:imposter/core/constants/game_json_keys.dart';
import 'package:imposter/core/error/exceptions.dart';
import 'package:imposter/core/utils/app_logger.dart';
import 'package:imposter/features/game/data/models/category_model.dart';

abstract class GameLocalDataSource {
  Future<List<CategoryModel>> getCategories();
}

class GameLocalDataSourceImpl implements GameLocalDataSource {
  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      AppLogger.info('Loading categories from topics.json asset');
      final jsonString = await rootBundle.loadString(
        GameJsonKeys.topicsJsonPath,
      );
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

      final categoriesList = jsonData[GameJsonKeys.categories] as List<dynamic>;

      final categories = categoriesList
          .map((item) => CategoryModel.fromMap(item as Map<String, dynamic>))
          .toList();

      AppLogger.info('Successfully loaded ${categories.length} categories');
      return categories;
    } on Exception catch (e, stackTrace) {
      AppLogger.error('Failed to load categories', e, stackTrace);
      throw AssetException(
        'Failed to load or parse topics asset: $e',
        stackTrace,
      );
    } catch (e, stackTrace) {
      AppLogger.error('Unexpected error parsing categories', e, stackTrace);
      throw JsonParsingException(
        'Error parsing categories data: $e',
        stackTrace,
      );
    }
  }
}
