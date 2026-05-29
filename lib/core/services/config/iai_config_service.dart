import 'package:imposter/core/error/result.dart';

abstract class IAIConfigService {
  Future<Result<String>> getTopicsAiKey();
}
