abstract class AppAssets {
  // base paths
  static const String _baseSvg = 'assets/svgs';
  static const String _baseImage = 'assets/images';
  static const String _baseAudio = 'assets/audio';

  // svgs
  static const String fingerprintSvg = '$_baseSvg/fingerprint.svg';
  static const String spySvg = '$_baseSvg/incognito.svg';
  static const String logoSvg = '$_baseSvg/logo.svg';
  static const String peopleGroupSvg = '$_baseSvg/people_group.svg';
  static const String playSvg = '$_baseSvg/play.svg';
  static const String redoSvg = '$_baseSvg/redo.svg';
  static const String timeOclockSvg = '$_baseSvg/time_oclock.svg';
  static const String backIconSvg = '$_baseSvg/back_icon.svg';
  static const String arrowLineLongSvg = '$_baseSvg/arrow_line_long.svg';
  static const String trophySvg = '$_baseSvg/trophy.svg';
  static const String animalsSvg = '$_baseSvg/animals.svg';
  static const String foodSvg = '$_baseSvg/food.svg';
  static const String placesSvg = '$_baseSvg/places.svg';
  static const String professionsSvg = '$_baseSvg/professions.svg';
  static const String thingsSvg = '$_baseSvg/things.svg';
  static const String facebookSvg = '$_baseSvg/facebook.svg';

  // images
  static const String paperWebp = '$_baseImage/paper_texture.webp';
  static const String logoSplashIcon = '$_baseImage/logo_splash_icon.png';

  // audios
  static const String win = '$_baseAudio/win.mp3';

  static String getCategoryIcon(String id) {
    return switch (id) {
      'places' => placesSvg,
      'food' => foodSvg,
      'jobs' => professionsSvg,
      'animals' => animalsSvg,
      'objects' => thingsSvg,
      'sports_figures' => trophySvg,
      _ => logoSvg,
    };
  }
}
