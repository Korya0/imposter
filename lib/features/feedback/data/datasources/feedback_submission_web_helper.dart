import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'package:imposter/features/feedback/keys.dart';
import 'package:imposter/core/utils/app_logger.dart';

/// Web implementation for feedback submission using JS interop.
/// This file is only compiled for the web platform.
Future<void> submitFeedbackWeb(Map<String, String> formData) async {
  try {
    final options = {
      FeedbackKeys.keyMethod: FeedbackKeys.methodPost,
      FeedbackKeys.keyMode: FeedbackKeys.modeNoCors,
      FeedbackKeys.keyHeaders: {
        FeedbackKeys.keyContentType: FeedbackKeys.contentTypeUrlEncoded,
      },
      FeedbackKeys.keyBody: Uri(queryParameters: formData).query,
    }.jsify()! as JSObject;

    globalContext.callMethod(
      FeedbackKeys.fetchMethod.toJS,
      FeedbackKeys.formUrl.toJS,
      options,
    );

    AppLogger.info(
      'Feedback submission triggered via JS Fetch (no-cors mode for Web).',
    );
  } catch (e, stackTrace) {
    AppLogger.error('Failed to submit feedback via JS Fetch on Web', e, stackTrace);
    rethrow;
  }
}
