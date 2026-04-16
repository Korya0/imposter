import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/widgets/app_button.dart';

class GameFinishTurnButton extends StatelessWidget {
  final VoidCallback onPressed;
  const GameFinishTurnButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      width: double.infinity,
      height: (context.height * 0.1).clamp(50, 70),
      title: AppStrings.finishTurn,
      onTap: onPressed,
    );
  }
}
