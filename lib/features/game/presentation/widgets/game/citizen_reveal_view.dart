import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/widgets/app_sketchy_card/app_sketchy_card.dart';
import 'package:imposter/core/theme/app_text_styles.dart';

class CitizenRevealView extends StatelessWidget {
  final String category;
  final String word;

  const CitizenRevealView({
    super.key,
    required this.category,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSketchyCard(
            height: 150,
            title: word,
            style: AppTextStyles.font45W800Primary,
          ),
        ],
      ),
    );
  }
}
