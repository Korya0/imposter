import 'package:flutter/material.dart';
import 'package:imposter/core/widgets/app_sketchy_card/app_sketchy_card.dart';

class CitizenRevealView extends StatelessWidget {
  final String secretWord;
  const CitizenRevealView({
    super.key,
    this.secretWord = 'مسجد', // TODO: Binding
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppSketchyCard(
          title: secretWord,
        ),
      ],
    );
  }
}
