import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/presentation/widgets/app_logo_header.dart';
import 'package:imposter/features/home/presentation/widgets/home_buttons_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: AppPaddings.h18,
              child: _HomeViewBody(),
            ),
          ),
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
