import 'package:flutter/material.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/home/presentation/widgets/home_app_name_and_logo.dart';
import 'package:imposter/features/home/presentation/widgets/home_buttons_section.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

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
