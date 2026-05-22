import 'package:flutter/material.dart';

abstract class AppFonts {
  static const String mainFont = 'ElMessiri';
  static const String secondFont = 'ArefRuqaa';
}

enum FontWeightHelper {
  w400(FontWeight.w400),
  w700(FontWeight.w700)
  ;

  final FontWeight weight;
  const FontWeightHelper(this.weight);
}
