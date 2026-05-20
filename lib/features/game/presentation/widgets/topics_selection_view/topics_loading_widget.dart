import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_sketchy_card/app_sketchy_card.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TopicsLoadingWidget extends StatelessWidget {
  const TopicsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: context.p(12),
          mainAxisSpacing: context.p(12),
          childAspectRatio:
              (context.width.clamp(0.0, 500.0) / 2) /
              (context.height.clamp(0.0, 900.0) * 0.28),
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return const AppSketchyCard(
            title: AppStrings.loadingCategory,
          );
        },
      ),
    );
  }
}
