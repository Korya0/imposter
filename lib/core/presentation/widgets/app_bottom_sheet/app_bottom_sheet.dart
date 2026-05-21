import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/presentation/painters/torn_paper_painter.dart';
import 'package:imposter/core/presentation/widgets/app_back_button.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

Future<void> showAppBottomSheet({
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
    barrierColor: AppColors.background.withValues(alpha: 0.5),
    builder: (context) => Stack(
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
            child: Container(color: Colors.transparent),
          ),
        ),
        RepaintBoundary(
          child: AppBottomSheet(
            height: height,
            title: title,
            child: child,
          ),
        ),
      ],
    ),
  );
}

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

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxWidth: 500,
          maxHeight: height ?? MediaQuery.sizeOf(context).height * 0.8,
        ),
        child: CustomPaint(
          painter: TornPaperPainter(color: AppColors.secondaryBackground),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                context.p(24),
                context.p(26),
                context.p(24),
                context.p(20) + bottomInset,
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _BottomSheetHeader(title: title),
                    const AppGap(20),
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
    );
  }
}

class _BottomSheetHeader extends StatelessWidget {
  final String? title;
  const _BottomSheetHeader({this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (title == null)
          const SizedBox.shrink()
        else
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: AppTextWidget(
              title!,
              style: AppTextStyles.font24W700PrimaryWithSpacing4,
            ),
          ),
        AppBackButton(
          onTap: () => context.pop(),
        ),
      ],
    );
  }
}

