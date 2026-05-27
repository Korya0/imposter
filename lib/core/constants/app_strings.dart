import 'dart:core';

abstract class AppStrings {
  // Common & Home
  static const String spy = 'الجاسوس';
  static const String howToPlay = 'إزاي نلعب؟';
  static const String letsGo = 'يلا بينا';

  // Category Selection
  static const String comingWithYou = 'تحبوا نلعب في إيه؟';

  // Game Settings
  static const String settings = 'تجهيز اللعبة';
  static const String numberOfPlayers = 'كام لاعب؟';
  static const String numberOfSpies = 'كام جاسوس؟';
  static const String numberOfMinutes = 'وقت الدور؟';
  static const String start = 'يلا نبدأ';
  static const String playerDefaultPrefix = 'لاعب';
  static const String playerNameHint = 'اكتب الاسم هنا';

  // Game Play - Scanning
  static const String scanHere = 'خليك باصم وثبت صباعك';

  // Game Play - Revealing
  static const String youAreTheSpy = 'أنت الجاسوس';

  // Game Play - Timer
  static const String ready = 'جاهزين؟ يلا بينا';
  static const String next = 'سلم للي بعدك';
  static const String startVoting = 'يلا نختار الجاسوس';

  // Game Play - Voting
  static const String whoIsTheSpy = 'مين الجاسوس في رأيكم؟';
  static const String goToSummary = 'يلا نشوف مين كسب';
  static const String maxSpiesSelectedWarning =
      'يا بطل، أخرك تختار {} جواسيس بس';
  static const String playersNotFinishedVoting =
      'استنوا، فيه لاعيبة لسه مخلصتش تصويتها: {}';
  static const String playersWhoCaughtSpy = 'الأبطال اللي قفشوا الجاسوس';
  static const String spyGotAway = 'الجاسوس هرب وضحك عليكم';

  // Game Summary
  static const String summary = 'خلاصه الدور';
  static const String word = 'الكلمة';
  static const String anotherRound = 'دور كمان؟';
  static const String finishGame = 'خلاص كفاية كده';

  // Errors
  static const String tryAgain = 'جرب تاني';
  static const String loadingCategory = 'بيحمل...';
  static const String errorDataParsing = 'حصلت لخبطة في اللعبة.. معلش جرب تاني';
  static const String errorStorage =
      'مش عارفين نحفظ بياناتك.. اتأكد من المساحة';
  static const String errorAsset = 'ملفات اللعبة فيها مشكلة.. حاول تفتحها تاني';
  static const String errorUnexpected = 'أوبس! حصلت حاجة غريبة.. جرب تاني كده؟';
  static const String oopsYouLost = 'أوبس! شكلك تهت في الطريق؟';
  static const String backToHome = 'نرجع للرئيسية';
  static const String tellUs = 'فضفض لنا';
  static const String sendFeedback = 'ابعت';
  static const String feedbackPlaceholder =
      'قولنا إيه اللي عجبك أو مضايقك هنا...';

  static const String feedbackSuccess = 'رأيك وصل في أمان! تسلم إيدك';
  static const String feedbackError = 'معلش حصلت مشكلة في الإرسال.. جرب تاني؟';
  static const String feedbackEmptyError = 'قولنا أي حاجة تفيدنا';

  static const String feedbackSubtitle =
      'رأيك يهمنا جداً عشان نطور اللعبة! شاركنا بأفكارك أو أي مشكلة واجهتك';
  static const String noInternetError =
      'مفيش إنترنت! اتأكد من الواي فاي أو الباقة';

  // Settings Limits
  static const String playerNameEmptyError = 'لازم تكتب اسم اللاعب';
  static const String playerNameValidationError =
      'ظبط أسماء اللاعبين الأول عشان نبدأ';
}
