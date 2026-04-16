import 'package:flutter/material.dart';
import 'package:imposter/core/widgets/app_sketchy_card/app_sketchy_card.dart';

class CitizenRevealView extends StatelessWidget {
  final String word;

  const CitizenRevealView({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppSketchyCard(
        height: 150,
        title: word,
      ),
    );
  }
}
