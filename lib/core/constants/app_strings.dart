abstract class AppStrings {
  // Common & Home
  static const String spy = 'الجاسوس';
  static const String howToPlay = 'أزاي تلعب';
  static const String letsGo = 'يلا بينا';
  static const String drawer = 'الدرج';
  static const String online = 'أونلاين';
  static const String comingSoon = 'قريبا';

  // Category Selection
  static const String comingWithYou = 'جايه معاك بايه ؟';
  static const String category = 'الموضوع';

  // Game Settings
  static const String numberOfPlayers = 'عدد الاعبين';
  static const String numberOfSpies = 'عدد الجواسيس';
  static const String numberOfMinutes = 'عدد الدقائق';
  static const String start = 'ابدا';

  // Game Play - Scanning
  static const String player = 'Player';
  static const String scanHere = 'ابصم هنا';

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
  static const String errorDataParsing = 'حدث خطأ في معالجة بيانات اللعبة';
  static const String errorStorage = 'تعذر حفظ أو استرجاع البيانات المحلية';
  static const String errorAsset = 'ملف بيانات اللعبة غير موجود أو تالف';
  static const String errorUnexpected =
      'حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى';
  static const String oopsYouLost = 'أوبس تهت في الطريق؟';
  static const String backToHome = 'الرجوع للرئيسية';

  // Settings Limits
  static const String maxPlayersReached = 'وصلت لأقصى عدد لاعبين مسموح بيه';
  static const String minPlayersReached = 'لازم 3 لاعيبة على الأقل عشان تلعبوا';
  static const String maxSpiesReached =
      'عدد الجواسيس مينفعش يتخطى نص عدد اللعيبة';
  static const String minSpiesReached = 'لازم يكون فيه جاسوس واحد على الأقل';
  static const String maxMinutesReached = '30 دقيقة ده أقصى وقت مسموح بيه';
  static const String minMinutesReached = 'أقل وقت هو دقيقة واحدة';

  static const List<String> howToPlaySteps = [
    'فكرة اللعبة: في كل دور في مواطنين وجاسوس بينهم',
    'الأدوار: المواطن بيشوف الكلمة السرية، والجاسوس مايشوفش الكلمة',
    'الدور بيمشي بسؤال بين اللعيبة بالتتابع',
    'ممنوع نفس اللاعب يتسأل مرتين ورا بعد',
    'هدف المواطنين: يعرفوا مين الجاسوس قبل ما يخمّن الكلمة',
    'هدف الجاسوس: يندمج في الكلام من غير ما يتكشف ويحاول يعرف الكلمة',
    'الجاسوس يقدر يوقف الدور في أي وقت لو حب يخمّن',
    'لو تخمين الجاسوس صح: يكسب والدور ينتهي فورًا',
    'لو تخمينه غلط: يخرج من الدور واللعيبة تكمل',
    'لو الجاسوس ماوقفش الدور: اللعيبة تصوّت على أكتر شخص مشكوك فيه',
  ];
}
