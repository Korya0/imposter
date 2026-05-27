import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:imposter/core/constants/app_padding.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/custom_scroll_scaffold.dart';
import 'package:imposter/features/how_to_play/data/how_to_play_data.dart';
import 'package:imposter/features/how_to_play/presentation/widgets/how_to_play_section_widget.dart';

class HowToPlayView extends StatelessWidget {
  const HowToPlayView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollScaffold(
      title: AppStrings.howToPlay,
      slivers: [
        SliverPadding(
          padding: AppPadding.viewH22(context),
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
                    )
                    .animate()
                    .fadeIn(
                      delay: Duration(milliseconds: 300 + (index * 150)),
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                    )
                    .slideY(
                      begin: 0.1,
                      end: 0,
                      delay: Duration(milliseconds: 300 + (index * 150)),
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutCubic,
                    );
              },
              childCount: HowToPlayData.sections.length,
            ),
          ),
        ),
      ],
    );
  }
}
