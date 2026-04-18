import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:imposter/core/constants/feedback_constants.dart';
import 'package:imposter/core/utils/app_logger.dart';
import 'package:imposter/features/feedback/data/models/feedback_request.dart';

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
    AppLogger.debug('URL: ${FeedbackConstants.formUrl}');
    AppLogger.debug('Data: $formData');

    if (kIsWeb) {
      try {
        final options = {
          'method': FeedbackConstants.methodPost,
          'mode': FeedbackConstants.modeNoCors,
          'headers': {
            'Content-Type': FeedbackConstants.contentTypeUrlEncoded,
          },
          'body': Uri(queryParameters: formData).query,
        }.jsify()! as JSObject;

        globalContext.callMethod(
          FeedbackConstants.fetchMethod.toJS,
          FeedbackConstants.formUrl.toJS,
          options,
        );

        AppLogger.info(
          'Feedback submission triggered via JS Fetch (no-cors mode for Web).',
        );
        return;
      } catch (e) {
        AppLogger.error('Failed to submit feedback via JS Fetch on Web', e);
        rethrow;
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
        'Feedback submitted successfully. Response: ${response.statusCode}',
      );
    } on Exception catch (e) {
      AppLogger.error('Failed to submit feedback in DataSource', e);
      rethrow;
    }
  }
}
