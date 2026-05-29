import 'package:imposter/core/error/exceptions.dart';
import 'package:imposter/core/error/failures.dart';
import 'package:imposter/core/error/result.dart';
import 'package:imposter/core/utils/app_logger.dart';
import 'package:imposter/features/game/data/datasources/game_local_data_source.dart';
import 'package:imposter/features/game/domain/entities/category_entity.dart';
import 'package:imposter/features/game/domain/repositories/game_repository.dart';

class GameRepositoryImpl implements IGameRepository {
  GameRepositoryImpl({required this.localDataSource});
  final GameLocalDataSource localDataSource;

  @override
  Future<Result<List<CategoryEntity>>> getCategories() async {
    try {
      final models = await localDataSource.getCategories();
      final entities = models.map((m) => m.toEntity()).toList();
      return Success(entities);
    } on AppException catch (e, stackTrace) {
      AppLogger.warning('AppException in Repository: ${e.message}', e, stackTrace);
      return const FailureResult(DataParsingFailure());
    } on Exception catch (e, stackTrace) {
      AppLogger.error('Unexpected Exception in Repository', e, stackTrace);
      return const FailureResult(UnexpectedFailure());
    }
  }
}
