import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_sketchy_card/app_sketchy_card.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/presentation/widgets/custom_app_bar.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';
import 'package:imposter/features/game/presentation/cubit/game_state.dart';
import 'package:go_router/go_router.dart';

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
      padding: AppPaddings.bottomPaddingH05(context),
      child: Column(
        children: [
          const CustomAppBar(),
          AppTextWidget(
            AppStrings.comingWithYou,
            style: AppTextStyles.font22W200White,
          ),
          const SizedBox(height: 20),
          BlocBuilder<GameCubit, GameState>(
            builder: (context, state) {
              return switch (state) {
                GameInitial() || GameLoading(categories: []) => const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                GameError(message: final msg, categories: []) => Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: AppTextWidget(msg),
                    ),
                  ),
                GameCategoriesLoaded(categories: final cats) ||
                GameLoading(categories: final cats) ||
                GameError(categories: final cats) ||
                GameScanning(categories: final cats) ||
                GameRevealing(categories: final cats) ||
                GameReady(categories: final cats) ||
                GameTimer(categories: final cats) ||
                GameSummary(categories: final cats) =>
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio:
                          (context.width / 2) / (context.height * 0.27),
                    ),
                    itemCount: cats.length,
                    itemBuilder: (context, index) {
                      final category = cats[index];
                      return AppSketchyCard(
                        title: category.name,
                        onTap: () async {
                          context.read<GameCubit>().selectCategory(category);
                          await context.pushNamed(AppRoutes.gameSettings);
                        },
                        watermark: IgnorePointer(
                          child: SvgPicture.asset(
                            AppAssets.getCategoryIcon(category.id),
                            width: 100,
                            height: 100,
                            placeholderBuilder: (context) => const SizedBox(
                              width: 100,
                              height: 100,
                            ),
                          ),
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
                  ),
              };
            },
          ),
        ],
      ),
    );
  }
}
