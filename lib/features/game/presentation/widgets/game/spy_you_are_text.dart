import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';

class SpyYouAreText extends StatelessWidget {
  const SpyYouAreText({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTextWidget(
      AppStrings.youAreTheSpy,
      style: AppTextStyles.ruqaa60BoldPrimary,
    ).animate().fadeIn(duration: 800.ms).slideY(begin: -0.2, end: 0);
  }
}
