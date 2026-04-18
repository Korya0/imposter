import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:imposter/core/constants/feedback_constants.dart';
import 'package:imposter/core/utils/app_logger.dart';
import 'package:imposter/features/feedback/data/models/feedback_request.dart';

// Import the stub/web implementation conditionally
import 'feedback_submission_helper.dart'
    if (dart.library.js_interop) 'feedback_submission_web_helper.dart';

abstract class FeedbackRemoteDataSource {
  Future<void> submitFeedback(FeedbackRequest request);
}

class FeedbackRemoteDataSourceImpl implements FeedbackRemoteDataSource {
  final Dio _dio;

  FeedbackRemoteDataSourceImpl(this._dio);

  @override
  Future<void> submitFeedback(FeedbackRequest request) async {
    final formData = {
      FeedbackConstants.feedbackEntryId: request.content,
    };

    AppLogger.info('Attempting to submit feedback to Google Forms...');
    
    if (kIsWeb) {
      // Use the conditional helper for Web to avoid CORS issues via JS Interop
      // but only on platforms where it's supported.
      try {
        await submitFeedbackWeb(formData);
        return;
      } on Exception catch (e) {
        AppLogger.error('Failed to submit feedback via Web Helper', e);
        // Fallback to Dio if web helper fails
      }
    }

    try {
      final response = await _dio.post<dynamic>(
        FeedbackConstants.formUrl,
        data: formData,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      AppLogger.info(
        'Feedback submitted successfully via Dio. Response: ${response.statusCode}',
      );
    } on Exception catch (e) {
      AppLogger.error('Failed to submit feedback in DataSource', e);
      rethrow;
    }
  }
}
