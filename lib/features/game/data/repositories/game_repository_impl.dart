import 'package:imposter/core/error/exceptions.dart';
import 'package:imposter/core/error/failures.dart';
import 'package:imposter/core/error/result.dart';
import 'package:imposter/core/utils/app_logger.dart';
import 'package:imposter/features/game/data/datasources/game_local_data_source.dart';
import 'package:imposter/features/game/domain/entities/category_entity.dart';
import 'package:imposter/features/game/domain/repositories/game_repository.dart';

class GameRepositoryImpl implements IGameRepository {
  final GameLocalDataSource localDataSource;

  GameRepositoryImpl({required this.localDataSource});

  @override
  Future<Result<List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await localDataSource.getCategories();
      return Success(categories);
    } on AppException catch (e) {
      AppLogger.warning('AppException in Repository: ${e.message}');
      return const FailureResult(DataParsingFailure());
    } on Exception catch (e) {
      AppLogger.error('Unexpected Exception in Repository', e);
      return const FailureResult(UnexpectedFailure());
    }
  }
}
