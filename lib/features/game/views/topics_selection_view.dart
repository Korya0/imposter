import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/widgets/app_text_widget.dart';
import 'package:imposter/core/widgets/custom_app_bar.dart';
import 'package:imposter/features/game/widgets/topics_items_section.dart';

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
      padding: EdgeInsets.only(
        bottom: (context.height * 0.05).clamp(12, 32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const CustomAppBar(),

          Center(
            child: AppTextWidget(
              AppStrings.comingWithYou,
              style: AppTextStyles.font22W200Primary,
            ),
          ),
          const TopicsItemsSection(),
        ],
      ),
    );
  }
}
