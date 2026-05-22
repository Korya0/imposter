import 'dart:core';

abstract class AppStrings {
  // Common & Home
  static const String spy = 'الجاسوس';
  static const String howToPlay = 'أزاي تلعب';
  static const String letsGo = 'يلا بينا';
  static const String feedback = 'رأيك يهمنا';
  static const String comingSoon = 'قريبا';
  static const String close = 'إغلاق';

  // Category Selection
  static const String comingWithYou = 'جايه معاك بايه ؟';
  static const String category = 'الموضوع';

  // Game Settings
  static const String settings = 'الإعدادات';
  static const String numberOfPlayers = 'الاعبين';
  static const String numberOfSpies = 'الجواسيس';
  static const String numberOfMinutes = 'الدقائق';
  static const String start = 'ابدا';

  // Game Play - Scanning
  static const String player = 'Player';
  static const String scanHere = 'ابصم هنا';
  static const String keepHolding = 'خليك باصم...';
  static const String scanSuccess = 'تم البصم بنجاح';

  // Game Play - Revealing
  static const String youAreTheSpy = 'انت الجاسوس';
  static const String youAreNotTheSpy = 'انت مش جاسوس';

  // Game Play - Timer
  static const String ready = 'كده كله تمام';
  static const String finishTurn = 'أنهي الدور';
  static const String next = 'اللي بعده';

  // Game Summary
  static const String summary = 'ملخص الدور';
  static const String word = 'الكلمة';
  static const String anotherRound = 'دور تاني';
  static const String finishGame = 'أنهي اللعبة';

  // Errors
  static const String tryAgain = 'إعادة المحاولة';
  static const String loadingCategory = 'اسم التصنيف الافتراضي';
  static const String errorDataParsing = 'حدث خطأ في معالجة بيانات اللعبة';
  static const String errorStorage = 'تعذر حفظ أو استرجاع البيانات المحلية';
  static const String errorAsset = 'ملف بيانات اللعبة غير موجود أو تالف';
  static const String errorUnexpected =
      'حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى';
  static const String oopsYouLost = 'أوبس تهت في الطريق؟';
  static const String backToHome = 'الرجوع للرئيسية';
  static const String tellUs = 'هات اللى عندك';
  static const String dontLetHopeDown = 'متخليش العشم ياخدك';
  static const String sendFeedback = 'إرسال';
  static const String feedbackPlaceholder = 'اكتب مقترحك هنا...';
  static const String feedbackContactPlaceholder =
      'إيميلك أو رقم تليفونك (اختياري)...';
  static const String feedbackSuccess = 'شكراً لمشاركتك تم الإرسال بنجاح';
  static const String feedbackError = 'حدث خطأ أثناء الإرسال، حاول مرة أخرى';
  static const String feedbackEmptyError = 'اكتب رأيك الأول عشان نقراه!';
  static const String discardFeedbackTitle = 'تراجع عن الكتابة؟';
  static const String discardFeedbackMessage =
      'لو رجعت دلوقتي، كل الكلام اللي كتبته هيتمسح. متأكد إنك عايز تخرج؟';
  static const String continueWriting = 'كمل كتابة';
  static const String discardAndExit = 'امسح واخرج';
  static const String feedbackSubtitle =
      'رأيك بيساعدنا نطور اللعبة ونخليها أحسن! اكتب مقترحك أو لو قابلتك مشكلة.';
  static const String feedbackBusinessContact = 'تواصل لأغراض العمل';
  static const String shareAndRate = 'شارك وقيم';
  static const String shareApp = 'مشاركة التطبيق';
  static const String followUsOn = 'تابع التطبيق علي';
  static const String noInternetError =
      'لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة';

  // Settings Limits
  static const String maxPlayersReached = 'وصلت لأقصى عدد لاعبين مسموح بيه';
  static const String minPlayersReached = 'لازم 3 لاعيبة على الأقل عشان تلعبوا';
  static const String maxSpiesReached =
      'عدد الجواسيس مينفعش يتخطى نص عدد اللعيبة';
  static const String minSpiesReached = 'لازم يكون فيه جاسوس واحد على الأقل';
  static const String maxMinutesReached = '30 دقيقة ده أقصى وقت مسموح بيه';
  static const String minMinutesReached = 'أقل وقت هو دقيقة واحدة';
}
