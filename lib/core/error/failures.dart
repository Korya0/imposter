import '../constants/app_strings.dart';

sealed class Failure {
  final String message;

  const Failure(this.message);
}

class DataParsingFailure extends Failure {
  const DataParsingFailure() : super(AppStrings.errorDataParsing);
}

class StorageFailure extends Failure {
  const StorageFailure() : super(AppStrings.errorStorage);
}

class AssetFailure extends Failure {
  const AssetFailure() : super(AppStrings.errorAsset);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure() : super(AppStrings.errorUnexpected);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super(AppStrings.noInternetError);
}

class ServerFailure extends Failure {
  const ServerFailure() : super(AppStrings.feedbackError);
}
