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
              padding: AppPadding.viewH18(context),
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
    if (context.isLandscape) {
      return Row(
        spacing: context.p(80), 
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: context.p(18),
            children: [
              const AppNameText(),
              const AppLogo()
                  .animate()
                  .fadeIn(duration: 800.ms, curve: Curves.easeOut)
                  .slideY(begin: 0.1, end: 0),
            ],
          ),

          const HomeButtonsSection()
              .animate()
              .fadeIn(delay: 200.ms, duration: 800.ms, curve: Curves.easeOut)
              .slideY(begin: 0.05, end: 0),
        ],
      );
    }

    return Column(
      spacing: context.p(80),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          spacing: context.p(18),
          children: [
            const AppNameText(),
            const AppLogo()
                .animate()
                .fadeIn(duration: 800.ms, curve: Curves.easeOut)
                .slideY(begin: 0.1, end: 0),
          ],
        ),

        const HomeButtonsSection()
            .animate()
            .fadeIn(delay: 200.ms, duration: 800.ms, curve: Curves.easeOut)
            .slideY(begin: 0.05, end: 0),
      ],
    );
  }
}
