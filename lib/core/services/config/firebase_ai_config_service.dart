import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:imposter/core/error/failures.dart';
import 'package:imposter/core/error/result.dart';
import 'package:imposter/core/services/config/iai_config_service.dart';
import 'package:imposter/core/utils/app_logger.dart';

class FirebaseAiConfigService implements IAIConfigService {
  FirebaseAiConfigService(this._remoteConfig);
  final FirebaseRemoteConfig _remoteConfig;

  @override
  Future<Result<String>> getTopicsAiKey() async {
    try {
      AppLogger.info('Fetching Gemini API Key from Firebase Remote Config...');
      await _remoteConfig.fetchAndActivate();
      final apiKey = _remoteConfig.getString('gemini_api_key');
      
      if (apiKey.isEmpty) {
        AppLogger.error('Gemini API Key (gemini_api_key) is empty in Remote Config');
        return const FailureResult(UnexpectedFailure());
      }

      AppLogger.info('Gemini API Key successfully fetched.');
      return Success(apiKey);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('Failed to fetch Gemini API Key from Remote Config', e, stackTrace);
      return const FailureResult(UnexpectedFailure());
    }
  }
}
