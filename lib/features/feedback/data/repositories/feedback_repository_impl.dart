import 'dart:io';

import 'package:dio/dio.dart';
import 'package:imposter/core/error/failures.dart';
import 'package:imposter/core/error/result.dart';
import 'package:imposter/core/utils/app_logger.dart';
import 'package:imposter/features/feedback/data/datasources/feedback_remote_data_source.dart';
import 'package:imposter/features/feedback/data/models/feedback_request.dart';

class FeedbackRepositoryImpl {
  final FeedbackRemoteDataSource _remoteDataSource;

  FeedbackRepositoryImpl(this._remoteDataSource);

  Future<Result<void>> submitFeedback(FeedbackRequest request) async {
    try {
      await _remoteDataSource.submitFeedback(request);
      return const Success(null);
    } on DioException catch (e) {
      AppLogger.error('DioException in FeedbackRepository', e);
      if (e.error is SocketException ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        return const FailureResult(NetworkFailure());
      }
      return const FailureResult(ServerFailure());
    } on Exception catch (e) {
      AppLogger.error('Unexpected Exception in FeedbackRepository', e);
      return const FailureResult(UnexpectedFailure());
    }
  }
}
