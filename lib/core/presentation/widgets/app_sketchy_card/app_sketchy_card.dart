import 'package:imposter/core/constants/app_paddings.dart';
import 'package:flutter/material.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/presentation/widgets/app_sketchy_card/sketchy_card_painter.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';

class AppSketchyCard extends StatefulWidget {
  const AppSketchyCard({
    required this.title,
    super.key,
    this.watermark,
    this.width,
    this.height,
    this.showTape = true,
    this.onTap,
  });

  final String title;
  final Widget? watermark;
  final double? width;
  final double? height;
  final bool showTape;
  final VoidCallback? onTap;

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
    return Semantics(
      button: widget.onTap != null,
      label: widget.title,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => widget.onTap != null ? _controller.forward() : null,
        onTapUp: (_) => widget.onTap != null ? _controller.reverse() : null,
        onTapCancel: () => widget.onTap != null ? _controller.reverse() : null,
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final scale = 1.0 - (_controller.value * 0.05);

            return Transform.scale(
              scale: scale,
              child: Container(
                width: widget.width,
                height: widget.height,
                constraints: const BoxConstraints(
                  minHeight: 150,
                  minWidth: 250,
                ),
                margin: AppPaddings.sketchyCardMargin,
                child: RepaintBoundary(
                  child: CustomPaint(
                    painter: SketchyCardPainter(
                      color: AppColors.primary,
                      showTape: widget.showTape,
                      progress: _controller.value,
                    ),
                    child: Container(
                      padding: AppPaddings.all24,
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (widget.watermark != null)
                            ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                AppColors.primary.withValues(
                                  alpha: 0.1,
                                ),
                                BlendMode.srcIn,
                              ),
                              child: widget.watermark,
                            ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: AppTextWidget(
                              widget.title,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: AppTextStyles.ruqaa45BoldPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
