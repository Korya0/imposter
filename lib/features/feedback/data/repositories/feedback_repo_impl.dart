import 'dart:io';

import 'package:dio/dio.dart';
import 'package:imposter/core/error/failures.dart';
import 'package:imposter/core/error/result.dart';
import 'package:imposter/core/utils/app_logger.dart';
import 'package:imposter/features/feedback/data/datasources/feedback_remote_data_source.dart';
import 'package:imposter/features/feedback/data/models/feedback_request_model.dart';
import 'package:imposter/features/feedback/data/repositories/i_feedback_repository.dart';

class FeedbackRepoImpl implements IFeedbackRepository {
  FeedbackRepoImpl(this._remoteDataSource);
  final FeedbackRemoteDataSource _remoteDataSource;

  @override
  Future<Result<void>> submitFeedback(FeedbackRequestModel request) async {
    try {
      await _remoteDataSource.submitFeedback(request);
      return const Success(null);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('DioException in FeedbackRepository', e, stackTrace);
      if (e.error is SocketException ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        return const FailureResult(NetworkFailure());
      }
      return const FailureResult(ServerFailure());
    } on Exception catch (e, stackTrace) {
      AppLogger.error('Unexpected Exception in FeedbackRepository', e, stackTrace);
      return const FailureResult(UnexpectedFailure());
    }
  }
}
