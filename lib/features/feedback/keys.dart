abstract class FeedbackKeys {
  static const String formId = String.fromEnvironment(
    'FORM_ID',
    defaultValue: '1FAIpQLSdf1et94XrcLYP7qrA2R1FNWcUe2jbziDeih8sqS6GEDHmUIA',
  );
  static const String feedbackEntryId = String.fromEnvironment(
    'FEEDBACK_ENTRY_ID',
    defaultValue: 'entry.282375310',
  );
  static const String formUrl =
      'https://docs.google.com/forms/d/e/$formId/formResponse';

  // JS Fetch Constants for Web
  static const String methodPost = 'POST';
  static const String modeNoCors = 'no-cors';
  static const String contentTypeUrlEncoded =
      'application/x-www-form-urlencoded';
  static const String fetchMethod = 'fetch';

  // JS Fetch Map Keys
  static const String keyMethod = 'method';
  static const String keyMode = 'mode';
  static const String keyHeaders = 'headers';
  static const String keyContentType = 'Content-Type';
  static const String keyBody = 'body';
}
