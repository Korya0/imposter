import 'package:flutter/material.dart';

abstract class AppFonts {
  static const String arefRuqaa = 'ArefRuqaa';
  static const String lateef = 'Lateef';

  static const TextStyle arefRuqaaBase = TextStyle(
    fontFamily: arefRuqaa,
  );

  static const TextStyle lateefBase = TextStyle(
    fontFamily: lateef,
  );
}

enum RuqaaWeight {
  w400(FontWeight.w400),
  w700(FontWeight.w700)
  ;

  final FontWeight weight;
  const RuqaaWeight(this.weight);
}

enum LateefWeight {
  w200(FontWeight.w200),
  w300(FontWeight.w300),
  w400(FontWeight.w400),
  w500(FontWeight.w500),
  w600(FontWeight.w600),
  w700(FontWeight.w700),
  w800(FontWeight.w800)
  ;

  final FontWeight weight;
  const LateefWeight(this.weight);
}
