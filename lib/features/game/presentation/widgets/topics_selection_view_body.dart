import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/widgets/app_text_widget.dart';
import 'package:imposter/core/widgets/custom_app_bar.dart';
import 'package:imposter/features/game/presentation/widgets/topics_items_section.dart';

class TopicsSelectionViewBody extends StatelessWidget {
  const TopicsSelectionViewBody({super.key});

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
