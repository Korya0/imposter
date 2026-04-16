sealed class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const AppException(this.message, [this.stackTrace]);

  @override
  String toString() => 'AppException: $message';
}

class CacheException extends AppException {
  const CacheException(super.message, [super.stackTrace]);
}

class AssetException extends AppException {
  const AssetException(super.message, [super.stackTrace]);
}

class JsonParsingException extends AppException {
  const JsonParsingException(super.message, [super.stackTrace]);
}

class UnexpectedException extends AppException {
  const UnexpectedException(super.message, [super.stackTrace]);
}
