import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/presentation/widgets/app_sketchy_card.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/domain/entities/category_entity.dart';
import 'package:imposter/features/game/presentation/controller/game_setup_cubit/game_setup_cubit.dart';

class TopicsGridWidget extends StatelessWidget {
  const TopicsGridWidget({required this.categories, super.key});
  final List<CategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: context.p(28),
        mainAxisSpacing: context.p(38),
        childAspectRatio:
            (context.width.clamp(0.0, 500.0) / 2) /
            (context.height.clamp(0.0, 900.0) * 0.28),
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final category = categories[index];
          final animationDelayIndex = index.clamp(0, 5);

          return AppSketchyCard(
                key: ValueKey(category.id),
                title: category.name,
                maxLines: 2,
                onTap: () async {
                  context.read<GameSetupCubit>().selectCategory(category);
                  await context.pushNamed(AppRoutes.gameSettings);
                },
                watermark: IgnorePointer(
                  child: SvgPicture.asset(
                    AppAssets.getCategoryIcon(category.id),
                    width: context.s(80),
                    height: context.s(80),
                    placeholderBuilder: (context) => SizedBox(
                      width: context.s(80),
                      height: context.s(80),
                    ),
                  ),
                ),
              )
              .animate()
              .fadeIn(
                delay: Duration(milliseconds: 300 + (animationDelayIndex * 80)),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOut,
              )
              .slideY(
                begin: 0.15,
                end: 0,
                delay: Duration(milliseconds: 300 + (animationDelayIndex * 80)),
                duration: const Duration(milliseconds: 450),
                curve: Curves.easeOutCubic,
              );
        },
        childCount: categories.length,
      ),
    );
  }
}
