import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/presentation/widgets/custom_app_bar.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';
import 'package:imposter/features/game/presentation/cubit/game_state.dart';
import 'package:imposter/features/game/presentation/widgets/TopicsSelectionView/topics_error_widget.dart';
import 'package:imposter/features/game/presentation/widgets/TopicsSelectionView/topics_grid_widget.dart';
import 'package:imposter/features/game/presentation/widgets/TopicsSelectionView/topics_loading_widget.dart';

class TopicsSelectionView extends StatelessWidget {
  const TopicsSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: AppPaddings.h18,
              sliver: SliverToBoxAdapter(
                child: _TopicsSelectionHeader(),
              ),
            ),
            SliverPadding(
              padding: AppPaddings.h18,
              sliver: _TopicsSelectionContent(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopicsSelectionHeader extends StatelessWidget {
  const _TopicsSelectionHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(),
        AppTextWidget(
          AppStrings.comingWithYou,
          style: AppTextStyles.font22W200White,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _TopicsSelectionContent extends StatelessWidget {
  const _TopicsSelectionContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return switch (state) {
          GameInitial() ||
          GameLoading(categories: []) =>
            const SliverToBoxAdapter(child: TopicsLoadingWidget()),
          GameError(message: final msg, categories: []) =>
            SliverToBoxAdapter(child: TopicsErrorWidget(message: msg)),
          GameCategoriesLoaded(categories: final cats) ||
          GameLoading(categories: final cats) ||
          GameError(categories: final cats) ||
          GameScanning(categories: final cats) ||
          GameRevealing(categories: final cats) ||
          GameReady(categories: final cats) ||
          GameTimer(categories: final cats) ||
          GameSummary(
            categories: final cats,
          ) =>
            TopicsGridWidget(categories: cats),
        };
      },
    );
  }
}
