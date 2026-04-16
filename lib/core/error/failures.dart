abstract class Failure {
  final String message;
  const Failure(this.message);
}

class AssetsFailure extends Failure {
  const AssetsFailure(super.message);
}

class ParsingFailure extends Failure {
  const ParsingFailure(super.message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}
