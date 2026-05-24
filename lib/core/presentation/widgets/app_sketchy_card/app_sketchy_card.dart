import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/painters/sketchy_card_painter.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class AppSketchyCard extends StatelessWidget {
  const AppSketchyCard({
    required this.title,
    super.key,
    this.watermark,
    this.showTape = true,
    this.onTap,
    this.maxLines = 1,
  });

  final String title;
  final Widget? watermark;
  final bool showTape;
  final VoidCallback? onTap;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          minHeight: context.h(150),
          minWidth: context.w(250),
        ),

        child: RepaintBoundary(
          child: CustomPaint(
            painter: SketchyCardPainter(
              color: AppColors.primary,
              showTape: showTape,
            ),
            child: Container(
              padding: EdgeInsets.all(context.p(4)),
              alignment: Alignment.center,
              child: _CardInnerContent(
                title: title,
                watermark: watermark,
                maxLines: maxLines,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardInnerContent extends StatelessWidget {
  final String title;
  final Widget? watermark;
  final int maxLines;

  const _CardInnerContent({
    required this.title,
    required this.watermark,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (watermark != null)
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              AppColors.primary.withValues(alpha: 0.1),
              BlendMode.srcIn,
            ),
            child: watermark,
          ),
        AppTextWidget(
          title,
          textAlign: TextAlign.center,
          maxLines: maxLines,
          style: AppTextStyles.font28W700Primary,
        ),
      ],
    );
  }
}
