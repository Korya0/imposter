class AssetsException implements Exception {
  final String message;
  AssetsException(this.message);
}

class ParsingException implements Exception {
  final String message;
  ParsingException(this.message);
}
