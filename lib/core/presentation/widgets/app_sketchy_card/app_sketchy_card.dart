import 'package:flutter/material.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/presentation/painters/sketchy_card_painter.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';

class AppSketchyCard extends StatefulWidget {
  const AppSketchyCard({
    required this.title,
    super.key,
    this.watermark,
    this.width,
    this.height,
    this.minWidth,
    this.minHeight,
    this.showTape = true,
    this.onTap,
    this.style,
    this.maxLines = 1,
  });

  final String title;
  final Widget? watermark;
  final double? width;
  final double? height;
  final double? minWidth;
  final double? minHeight;
  final bool showTape;
  final VoidCallback? onTap;
  final TextStyle? style;
  final int maxLines;

  @override
  State<AppSketchyCard> createState() => _AppSketchyCardState();
}

class _AppSketchyCardState extends State<AppSketchyCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasTap = widget.onTap != null;
    return Semantics(
      button: hasTap,
      label: widget.title,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => hasTap ? _controller.forward() : null,
        onTapUp: (_) => hasTap ? _controller.reverse() : null,
        onTapCancel: () => hasTap ? _controller.reverse() : null,
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) => _InteractiveSketchyCard(
            scale: 1.0 - (_controller.value * 0.05),
            widget: widget,
            progress: _controller.value,
          ),
        ),
      ),
    );
  }
}

class _InteractiveSketchyCard extends StatelessWidget {
  final double scale;
  final AppSketchyCard widget;
  final double progress;

  const _InteractiveSketchyCard({
    required this.scale,
    required this.widget,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveMinWidth = widget.minWidth ?? context.w(250);
    final effectiveMinHeight = widget.minHeight ?? context.h(150);

    return Transform.scale(
      scale: scale,
      child: Container(
        width: widget.width,
        height: widget.height,
        constraints: BoxConstraints(
          minHeight: effectiveMinHeight,
          minWidth: effectiveMinWidth,
        ),
        margin: EdgeInsets.only(
          top: context.p(25),
          left: context.p(10),
          right: context.p(10),
        ),
        child: RepaintBoundary(
          child: CustomPaint(
            painter: SketchyCardPainter(
              color: AppColors.primary,
              showTape: widget.showTape,
              progress: progress,
            ),
            child: Container(
              padding: EdgeInsets.all(context.p(24)),
              alignment: Alignment.center,
              child: _CardInnerContent(
                title: widget.title,
                watermark: widget.watermark,
                maxLines: widget.maxLines,
                style: widget.style,
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
  final TextStyle? style;

  const _CardInnerContent({
    required this.title,
    required this.watermark,
    required this.maxLines,
    this.style,
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
        if (maxLines == 1)
          FittedBox(
            fit: BoxFit.scaleDown,
            child: AppTextWidget(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: style ?? AppTextStyles.font45W700Primary,
            ),
          )
        else
          AppTextWidget(
            title,
            textAlign: TextAlign.center,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: style ?? AppTextStyles.font24W700Primary,
          ),
      ],
    );
  }
}

