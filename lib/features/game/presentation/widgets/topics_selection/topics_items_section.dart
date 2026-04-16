import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/presentation/widgets/app_sketchy_card/app_sketchy_card.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';
import 'package:imposter/features/game/presentation/cubit/game_state.dart';

class TopicsItemsSection extends StatelessWidget {
  const TopicsItemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      buildWhen: (previous, current) =>
          current is GameCategoriesLoaded ||
          current is GameLoading ||
          current is GameError,
      builder: (context, state) {
        if (state is GameLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GameError) {
          return Center(child: Text(state.message));
        }

        final categories = state.categories;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: (context.width / 2) / (context.height * 0.27),
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return AppSketchyCard(
                  title: category.name,
                  onTap: () async {
                    context.read<GameCubit>().selectCategory(category);
                    await context.pushNamed(AppRoutes.gameSettings);
                  },
                  watermark: SvgPicture.asset(
                    category.icon,
                    width: 100,
                    height: 100,
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
      },
    );
  }
}
