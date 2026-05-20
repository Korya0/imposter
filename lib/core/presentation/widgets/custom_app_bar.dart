import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/presentation/widgets/app_back_button.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.title,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: context.p(20),
              left: context.p(10),
              right: context.p(10),
            ),
            child: SizedBox(
              height: 50,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 1. Perfectly Centered Title
                  if (title != null)
                    Center(
                      child: Text(
                        title!,
                        style: AppTextStyles.font24W700Primary,
                        textAlign: TextAlign.center,
                      ),
                    ),

                  // 2. Tactile Minimalist Back Icon Button (Primary Color)
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: AppBackButton(
                      onTap: () => context.pop(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(
          begin: -0.15,
          end: 0,
          duration: 450.ms,
          curve: Curves.easeOutQuad,
        );
  }
}

