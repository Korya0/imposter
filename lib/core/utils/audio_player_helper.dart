import 'package:audioplayers/audioplayers.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/di/di.dart';
import 'package:imposter/core/utils/app_logger.dart';

class AudioPlayerHelper {
  static Future<void> playWin() async {
    try {
      final player = sl<AudioPlayer>();
      final path = AppAssets.win.replaceFirst('assets/', '');
      await player.play(AssetSource(path));
      AppLogger.info('Playing win sound: $path');
    } on Exception catch (e) {
      AppLogger.error('Failed to play win sound', e);
    }
  }
}
