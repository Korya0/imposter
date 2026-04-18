import 'package:audioplayers/audioplayers.dart';
import 'package:imposter/core/constants/app_assets.dart';

class AudioPlayerHelper {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playWin() async {
    await _player.stop();
    await _player.setReleaseMode(ReleaseMode.release);
    await _player.play(AssetSource(AppAssets.win.replaceFirst('assets/', '')));
  }

  static Future<void> stop() async {
    await _player.stop();
  }
}
