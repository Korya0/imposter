import 'package:flutter/services.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/di/di.dart';
import 'package:soundpool/soundpool.dart';

class AudioPlayerHelper {
  static int? _winSoundId;

  static Future<void> playWin() async {
    final pool = sl<Soundpool>();

    _winSoundId ??= await rootBundle.load(AppAssets.win).then(pool.load);

    if (_winSoundId != null) {
      await pool.play(_winSoundId!);
    }
  }
}
