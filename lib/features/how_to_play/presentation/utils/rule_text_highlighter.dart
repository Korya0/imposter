import 'package:flutter/material.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class RuleTextHighlighter {
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

  static InlineSpan getCachedSpan(BuildContext context, String text) {
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
          fontSize: context.f(18),
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
              fontSize: context.f(18),
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
            fontSize: context.f(18),
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
            fontSize: context.f(18),
          ),
        ),
      );
    }

    final resultSpan = TextSpan(children: spans);
    _spanCache[text] = resultSpan;
    return resultSpan;
  }
}
