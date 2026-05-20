import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_padding.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_back_button.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/features/how_to_play/data/how_to_play_data.dart';
import 'package:imposter/features/how_to_play/presentation/widgets/how_to_play_section_widget.dart';

class HowToPlayView extends StatelessWidget {
  const HowToPlayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            surfaceTintColor: Colors.transparent,
            floating: true,
            snap: true,
            elevation: 0,
            leading: AppBackButton(
              onTap: () => context.pop(),
            ),
            title: Text(
              AppStrings.howToPlay,
              style: AppTextStyles.font24W700Primary,
            ),
            centerTitle: true,
          ),
          const SliverToBoxAdapter(
            child: AppGap(8),
          ),
          SliverPadding(
            padding: AppPadding.viewH18(context),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final section = HowToPlayData.sections[index];
                  final isLastSection =
                      index == HowToPlayData.sections.length - 1;

                  var startingStep = 1;
                  for (var i = 0; i < index; i++) {
                    startingStep += HowToPlayData.sections[i].rules.length;
                  }

                  return HowToPlaySectionWidget(
                    section: section,
                    isLastSection: isLastSection,
                    startingStepNumber: startingStep,
                  );
                },
                childCount: HowToPlayData.sections.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: AppGap(40),
          ),
        ],
      ),
    );
  }
}
