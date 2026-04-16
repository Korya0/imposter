import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/features/home/presentation/widgets/home_app_name_and_logo.dart';
import 'package:imposter/features/home/presentation/widgets/home_buttons_section.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.bottomPaddingH05(context),
      child: Column(
        spacing: AppPaddings.heightH10(context),
        children: const [
          HomeAppNameAndLogo(),
          HomeButtonsSection(),
        ],
      ),
    );
  }
}
