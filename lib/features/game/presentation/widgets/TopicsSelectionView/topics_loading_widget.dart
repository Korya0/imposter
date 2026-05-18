import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:imposter/core/presentation/widgets/app_sketchy_card/app_sketchy_card.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

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
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio:
              (context.width.clamp(0.0, 500.0) / 2) /
              (context.height.clamp(0.0, 900.0) * 0.28),
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return AppSketchyCard(
            title: 'اسم التصنيف الافتراضي',
            minWidth: 0,
            minHeight: 0,
            maxLines: 2,
            style: AppTextStyles.font24W700Primary,
          );
        },
      ),
    );
  }
}
