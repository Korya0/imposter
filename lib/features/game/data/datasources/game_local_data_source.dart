import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:imposter/core/constants/app_constants.dart';
import 'package:imposter/core/error/exceptions.dart';
import 'package:imposter/core/utils/app_logger.dart';
import 'package:imposter/features/game/data/models/category_model.dart';

abstract class GameLocalDataSource {
  Future<List<CategoryModel>> getCategories();
}

class AssetDataSource implements GameLocalDataSource {
  List<CategoryModel>? _cachedCategories;

  @override
  Future<List<CategoryModel>> getCategories() async {
    if (_cachedCategories != null) {
      AppLogger.debug(
        'Returning cached categories (Count: ${_cachedCategories!.length})',
      );
      return _cachedCategories!;
    }

    AppLogger.info(
      'Loading categories from assets: ${AppConstants.topicsJsonPath}',
    );

    try {
      final jsonString = await rootBundle.loadString(
        AppConstants.topicsJsonPath,
      );
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;

      final categoriesJson = jsonData[AppConstants.categoriesKey];
      if (categoriesJson == null || categoriesJson is! List) {
        throw ParsingException('Categories key missing or invalid in JSON');
      }

      _cachedCategories = categoriesJson
          .map(
            (category) =>
                CategoryModel.fromJson(category as Map<String, dynamic>),
          )
          .toList();

      AppLogger.info(
        'Successfully loaded ${_cachedCategories!.length} categories',
      );

      return _cachedCategories!;
    } on PlatformException catch (e, stackTrace) {
      AppLogger.error('Asset loading error', e, stackTrace);
      throw AssetsException('Failed to load assets: ${e.message}');
    } catch (e, stackTrace) {
      if (e is ParsingException) {
        AppLogger.warning('JSON parsing warning', e, stackTrace);
        rethrow;
      }
      AppLogger.error('Unexpected error during data loading', e, stackTrace);
      throw ParsingException('Failed to parse topics data: $e');
    }
  }
}
