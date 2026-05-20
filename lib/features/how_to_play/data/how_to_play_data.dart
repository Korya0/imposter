class HowToPlaySection {
  final String title;
  final List<String> rules;

  const HowToPlaySection({
    required this.title,
    required this.rules,
  });
}

class HowToPlayData {
  static const List<HowToPlaySection> sections = [
    HowToPlaySection(
      title: 'الفكرة والأدوار',
      rules: [
        'فكرة اللعبة: في كل دور في مواطنين وجاسوس بينهم',
        'الأدوار: المواطن بيشوف الكلمة السرية، والجاسوس مايشوفش الكلمة',
      ],
    ),
    HowToPlaySection(
      title: 'طريقة اللعب والسؤال',
      rules: [
        'الدور بيمشي بسؤال بين اللعيبة بالتتابع',
        'ممنوع نفس اللاعب يتسأل مرتين ورا بعد',
        'هدف المواطنين: يعرفوا مين الجاسوس قبل ما يخمّن الكلمة',
        'هدف الجاسوس: يندمج في الكلام من غير ما يتكشف ويحاول يعرف الكلمة',
      ],
    ),
    HowToPlaySection(
      title: 'التخمين والتصويت',
      rules: [
        'الجاسوس يقدر يوقف الدور في أي وقت لو حب يخمّن',
        'لو تخمين الجاسوس صح: يكسب والدور ينتهي فورًا',
        'لو تخمينه غلط: يخرج من الدور واللعيبة تكمل',
        'لو الجاسوس ماوقفش الدور: اللعيبة تصوّت على أكتر شخص مشكوك فيه',
      ],
    ),
  ];
}
