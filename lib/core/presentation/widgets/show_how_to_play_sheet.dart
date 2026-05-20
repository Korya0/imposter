import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_bottom_sheet/app_bottom_sheet.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/presentation/widgets/tactile_sketchy_icon_button.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';

class _RuleCategory {
  final String title;
  final List<int> stepIndexes;

  const _RuleCategory({
    required this.title,
    required this.stepIndexes,
  });
}

class HowToPlaySheetContent extends StatelessWidget {
  const HowToPlaySheetContent({super.key});

  static const List<_RuleCategory> _categories = [
    _RuleCategory(
      title: 'الفكرة والأدوار',
      stepIndexes: [0, 1],
    ),
    _RuleCategory(
      title: 'طريقة اللعب والسؤال',
      stepIndexes: [2, 3, 4, 5],
    ),
    _RuleCategory(
      title: 'التخمين والتصويت',
      stepIndexes: [6, 7, 8, 9],
    ),
  ];

  static const List<String> _wordsToHighlight = [
    'الجاسوس',
    'المواطن',
    'المواطنين',
    'الكلمة السرية',
    'الكلمة',
    'تصوّت',
    'يخمّن',
    'تخمين',
    'تخمينه',
    'الأدوار',
  ];

  // Pre-compiled RegExp pattern for optimal performance
  static final RegExp _highlightPattern = RegExp(
    '(${_wordsToHighlight.map(RegExp.escape).join('|')})',
  );

  // High-performance static cache for memoizing parsed TextSpans
  static final Map<String, InlineSpan> _spanCache = {};

  static InlineSpan _getCachedSpan(String text) {
    // Return immediately if already parsed
    final cached = _spanCache[text];
    if (cached != null) return cached;

    final matches = _highlightPattern.allMatches(text);
    if (matches.isEmpty) {
      final span = TextSpan(
        text: text,
        style: AppTextStyles.font18W700Primary.copyWith(
          color: AppColors.white.withValues(alpha: 0.85),
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      );
      _spanCache[text] = span;
      return span;
    }

    final spans = <TextSpan>[];
    var lastIndex = 0;

    for (final match in matches) {
      if (match.start > lastIndex) {
        spans.add(
          TextSpan(
            text: text.substring(lastIndex, match.start),
            style: AppTextStyles.font18W700Primary.copyWith(
              color: AppColors.white.withValues(alpha: 0.85),
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
          ),
        );
      }
      spans.add(
        TextSpan(
          text: match.group(0),
          style: AppTextStyles.font18W700Primary.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      );
      lastIndex = match.end;
    }

    if (lastIndex < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastIndex),
          style: AppTextStyles.font18W700Primary.copyWith(
            color: AppColors.white.withValues(alpha: 0.85),
            fontWeight: FontWeight.normal,
            fontSize: 18,
          ),
        ),
      );
    }

    final resultSpan = TextSpan(children: spans);
    _spanCache[text] = resultSpan;
    return resultSpan;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(_categories.length, (index) {
          final isLast = index == _categories.length - 1;
          return _HowToPlayCategorySection(
            category: _categories[index],
            isLast: isLast,
          );
        }),
      ),
    );
  }
}

class _HowToPlayCategorySection extends StatelessWidget {
  const _HowToPlayCategorySection({
    required this.category,
    required this.isLast,
  });

  final _RuleCategory category;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          child: AppTextWidget(
            category.title,
            style: AppTextStyles.font24W700Primary,
          ),
        ),
        ...category.stepIndexes.map((index) {
          final step = AppStrings.howToPlaySteps[index];
          return _HowToPlayStepRow(
            index: index,
            stepText: step,
          );
        }),
        if (!isLast)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: SizedBox(
              width: double.infinity,
              height: 4,
              child: CustomPaint(
                painter: _SketchyHorizontalLinePainter(
                  color: AppColors.secondaryBackground,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _SketchyHorizontalLinePainter extends CustomPainter {
  const _SketchyHorizontalLinePainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final path = Path()..moveTo(0, size.height / 2);

    const steps = 24;
    final stepWidth = size.width / steps;
    for (var i = 1; i <= steps; i++) {
      final x = i * stepWidth;
      final y = size.height / 2 + 0.8 * sin(i * 1.5);
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SketchyHorizontalLinePainter oldDelegate) =>
      oldDelegate.color != color;
}

class _HowToPlayStepRow extends StatelessWidget {
  const _HowToPlayStepRow({
    required this.index,
    required this.stepText,
  });

  final int index;
  final String stepText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 28,
            height: 28,
            child: CustomPaint(
              painter: QuietSketchyPainter(
                color: AppColors.primary,
              ),
              child: Center(
                child: AppTextWidget(
                  (index + 1).toString(),
                  style: AppTextStyles.font15W700Primary.copyWith(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text.rich(
              HowToPlaySheetContent._getCachedSpan(stepText),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}

void showHowToPlaySheet(BuildContext context) {
  unawaited(
    AppBottomSheet.show(
      context: context,
      title: AppStrings.howToPlay,
      child: const HowToPlaySheetContent(),
    ),
  );
}
