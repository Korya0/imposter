import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/presentation/widgets/app_bottom_sheet/torn_paper_painter.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_text_styles.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    required this.child,
    super.key,
    this.title,
    this.height,
  });
  final Widget child;
  final String? title;
  final double? height;

  static Future<void> show({
    required BuildContext context,
    required Widget child,
    String? title,
    double? height,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      elevation: 0,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.transparent),
            ),
          ),
          AppBottomSheet(
            height: height,
            title: title,
            child: child,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxWidth: 550,
          maxHeight: height ?? MediaQuery.of(context).size.height * 0.8,
        ),
        child: CustomPaint(
          painter: TornPaperPainter(color: AppColors.secondaryBackground),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(bottom: bottomInset),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 26, 24, 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (title == null)
                            const SizedBox.shrink()
                          else
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: AppTextWidget(
                                title!,
                                style: AppTextStyles.font24W800Primary,
                              ),
                            ),
                          Semantics(
                            button: true,
                            label: 'إغلاق',
                            child: TextButton(
                              onPressed: () => context.pop(),
                              child: AppTextWidget(
                                'إغلاق',
                                style: AppTextStyles.font24W800Primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Flexible(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: child,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
