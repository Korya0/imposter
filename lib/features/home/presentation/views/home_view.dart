import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:imposter/core/constants/app_padding.dart';
import 'package:imposter/core/presentation/widgets/app_logo.dart';
import 'package:imposter/core/presentation/widgets/app_name_text.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/home/presentation/widgets/home_buttons_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: AppPadding.viewH22(context),
              child: const _HomeViewBody(),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeViewBody extends StatelessWidget {
  const _HomeViewBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: context.p(80),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          spacing: context.p(18),
          children: [
            const AppNameText()
                .animate()
                .fadeIn(
                  duration: const Duration(milliseconds: 450),
                  curve: Curves.easeOut,
                )
                .slideY(
                  begin: -0.2,
                  end: 0,
                  duration: const Duration(milliseconds: 450),
                  curve: Curves.easeOutQuad,
                ),
            const AppLogo()
                .animate()
                .fadeIn(
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 450),
                  curve: Curves.easeOut,
                )
                .scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1, 1),
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 550),
                  curve: Curves.easeOutBack,
                ),
          ],
        ),

        const HomeButtonsSection(),
      ],
    );
  }
}
