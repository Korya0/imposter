import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/presentation/widgets/app_logo_header.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/home/presentation/widgets/home_buttons_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
                  child: const _HomeViewBody(),
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
  const _HomeViewBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.bottomPaddingH05(context),
      child: Column(
        spacing: AppPaddings.heightH10(context),
        children: const [
          AppLogoHeader(
            shouldAnimate: true,
          ),
          HomeButtonsSection(),
        ],
      ),
    );
  }
}
