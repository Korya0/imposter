import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/widgets/app_button.dart';

class GameFinishGameButton extends StatelessWidget {
  final VoidCallback onPressed;
  const GameFinishGameButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      width: double.infinity,
      height: (context.height * 0.1).clamp(50, 70),
      title: AppStrings.finishGame,
      onTap: onPressed,
    );
  }
}
