import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/widgets/app_button.dart';

class GameNextButton extends StatelessWidget {
  final VoidCallback onPressed;
  const GameNextButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      title: AppStrings.next,
      onTap: onPressed,
    );
  }
}
