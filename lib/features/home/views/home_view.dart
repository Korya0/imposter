import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/home/widgets/home_app_name_and_logo.dart';
import 'package:imposter/features/home/widgets/home_buttons_section.dart';

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
      padding: EdgeInsets.only(bottom: (context.height * 0.05).clamp(12, 32)),
      child: Column(
        spacing: (context.height * 0.1).clamp(0, 100),
        children: const [
          HomeAppNameAndLogo(),
          HomeButtonsSection(),
        ],
      ),
    );
  }
}
