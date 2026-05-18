import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:imposter/core/constants/app_padding.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/presentation/widgets/app_logo_header.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/home/presentation/widgets/home_buttons_section.dart';

class HomeView extends StatelessWidget {
  final VoidCallback onFeedbackTap;

  const HomeView({
    required this.onFeedbackTap,
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
              child: _HomeViewBody(onFeedbackTap: onFeedbackTap),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeViewBody extends StatelessWidget {
  final VoidCallback onFeedbackTap;

  const _HomeViewBody({
    required this.onFeedbackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const AppLogoHeader()
            .animate()
            .fadeIn(duration: 800.ms, curve: Curves.easeOut)
            .slideY(begin: 0.1, end: 0),
        SizedBox(height: context.p(48)),
        HomeButtonsSection(onFeedbackTap: onFeedbackTap)
            .animate()
            .fadeIn(delay: 200.ms, duration: 800.ms, curve: Curves.easeOut)
            .slideY(begin: 0.05, end: 0),

        const AppGap(20),
      ],
    );
  }
}
