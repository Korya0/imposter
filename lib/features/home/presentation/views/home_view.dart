import 'package:flutter/material.dart';
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
      body: Center(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.p(18)),
                  child: _HomeViewBody(onFeedbackTap: onFeedbackTap),
                ),
              ),
            ),
          ],
        ),
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
    return Padding(
      padding: EdgeInsets.only(bottom: context.p(24)),
      child: Column(
        spacing: context.p(40),
        children: [
          const AppLogoHeader(
            shouldAnimate: true,
          ),
          HomeButtonsSection(onFeedbackTap: onFeedbackTap),
        ],
      ),
    );
  }
}
