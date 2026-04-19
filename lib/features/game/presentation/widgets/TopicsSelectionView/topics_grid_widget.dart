import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/presentation/widgets/app_sketchy_card/app_sketchy_card.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/domain/entities/category_entity.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';

class TopicsGridWidget extends StatelessWidget {
  final List<CategoryEntity> categories;
  const TopicsGridWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: (context.width.clamp(0.0, 500.0) / 2) /
            (context.height.clamp(0.0, 900.0) * 0.28),
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final category = categories[index];
          return AppSketchyCard(
            title: category.name,
            onTap: () async {
              context.read<GameCubit>().selectCategory(category);
              await context.pushNamed(AppRoutes.gameSettings);
            },
            watermark: IgnorePointer(
              child: SvgPicture.asset(
                AppAssets.getCategoryIcon(category.id),
                width: 80,
                height: 80,
                placeholderBuilder: (context) => const SizedBox(
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          )
              .animate()
              .fadeIn(delay: (index % 6 * 100).ms, duration: 400.ms)
              .slideY(
                begin: 0.2,
                end: 0,
                duration: 500.ms,
                curve: Curves.easeOutQuad,
              );
        },
        childCount: categories.length,
      ),
    );
  }
}
