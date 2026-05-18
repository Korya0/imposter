import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/custom_app_bar.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';
import 'package:imposter/features/game/presentation/cubit/game_state.dart';
import 'package:imposter/features/game/presentation/widgets/TopicsSelectionView/topics_error_widget.dart';
import 'package:imposter/features/game/presentation/widgets/TopicsSelectionView/topics_grid_widget.dart';
import 'package:imposter/features/game/presentation/widgets/TopicsSelectionView/topics_loading_widget.dart';

class TopicsSelectionView extends StatelessWidget {
  const TopicsSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: context.p(18)),
              sliver: const SliverToBoxAdapter(
                child: _TopicsSelectionHeader(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: context.p(18)),
              sliver: const _TopicsSelectionContent(),
            ),
            const SliverToBoxAdapter(
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
    return const Column(
      children: [
        CustomAppBar(title: AppStrings.comingWithYou),
        SizedBox(height: 16),
      ],
    );
  }
}

class _TopicsSelectionContent extends StatelessWidget {
  const _TopicsSelectionContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      buildWhen: (previous, current) {
        // Only rebuild if the view's core visual states change
        final wasCore =
            previous is GameInitial ||
            previous is GameLoading ||
            previous is GameError ||
            previous is GameCategoriesLoaded;
        final isCore =
            current is GameInitial ||
            current is GameLoading ||
            current is GameError ||
            current is GameCategoriesLoaded;

        // Always rebuild if categories list changes
        if (previous.categories != current.categories) return true;

        // Otherwise, only rebuild if transitioning within the core selection lifecycle states
        return wasCore || isCore;
      },
      builder: (context, state) {
        return switch (state) {
          GameInitial() || GameLoading(categories: []) =>
            const SliverToBoxAdapter(child: TopicsLoadingWidget()),
          GameError(message: final msg, categories: []) => SliverToBoxAdapter(
            child: TopicsErrorWidget(message: msg),
          ),
          GameCategoriesLoaded(categories: final cats) ||
          GameLoading(categories: final cats) ||
          GameError(categories: final cats) ||
          GameScanning(categories: final cats) ||
          GameRevealing(categories: final cats) ||
          GameReady(categories: final cats) ||
          GameTimer(categories: final cats) ||
          GameSummary(
            categories: final cats,
          ) => TopicsGridWidget(categories: cats),
        };
      },
    );
  }
}
