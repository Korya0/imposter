import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/presentation/widgets/custom_app_bar.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/features/game/presentation/widgets/topics_selection/topics_items_section.dart';

class TopicsSelectionView extends StatelessWidget {
  const TopicsSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPaddings.h18,
          child: SingleChildScrollView(
            child: _TopicsSelectionViewBody(),
          ),
        ),
      ),
    );
  }
}

class _TopicsSelectionViewBody extends StatelessWidget {
  const _TopicsSelectionViewBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.bottomPaddingH05(context),
      child: Column(
        children: [
          const CustomAppBar(),
          AppTextWidget(
            AppStrings.comingWithYou,
            style: AppTextStyles.font22W200White,
          ),
          const TopicsItemsSection(),
        ],
      ),
    );
  }
}
