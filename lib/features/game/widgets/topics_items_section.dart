import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/widgets/app_sketchy_card/app_sketchy_card.dart';

class TopicsItemsSection extends StatelessWidget {
  const TopicsItemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final topics = [
      {'title': AppStrings.places, 'icon': AppSvgs.places},
      {'title': AppStrings.food, 'icon': AppSvgs.food},
      {'title': AppStrings.professions, 'icon': AppSvgs.professions},
      {'title': AppStrings.animals, 'icon': AppSvgs.animals},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: topics.length,
      itemBuilder: (context, index) {
        return AppSketchyCard(
              title: topics[index]['title']!,
              onTap: () async {
                await context.pushNamed(AppRoutes.gameSettings);
              },
              watermark: SvgPicture.asset(
                topics[index]['icon']!,
              ),
            )
            .animate()
            .fadeIn(delay: (index * 150).ms, duration: 500.ms)
            .slideX(
              begin: 1,
              end: 0,
              duration: 600.ms,
              curve: Curves.easeOutQuad,
            )
            .slideY(
              begin: 0.5,
              end: 0,
              duration: 600.ms,
              curve: Curves.easeOutQuad,
            );
      },
    );
  }
}
