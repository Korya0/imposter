/// Stub implementation for feedback submission.
/// This file is used on mobile platforms where dart:js_interop is not available.
Future<void> submitFeedbackWeb(Map<String, String> formData) async {
  // Do nothing on mobile, the main data source will fallback to Dio.
  throw UnsupportedError('JS Interop is only supported on Web');
}
