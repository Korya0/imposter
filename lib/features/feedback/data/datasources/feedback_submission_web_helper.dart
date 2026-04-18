import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'package:imposter/core/constants/feedback_constants.dart';
import 'package:imposter/core/utils/app_logger.dart';

/// Web implementation for feedback submission using JS interop.
/// This file is only compiled for the web platform.
Future<void> submitFeedbackWeb(Map<String, String> formData) async {
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
  } catch (e) {
    AppLogger.error('Failed to submit feedback via JS Fetch on Web', e);
    rethrow;
  }
}
