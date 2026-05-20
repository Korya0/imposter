import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/constants/app_padding.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/presentation/widgets/custom_scroll_scaffold.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';
import 'package:imposter/features/game/presentation/cubit/game_state.dart';
import 'package:imposter/features/game/presentation/widgets/topics_selection_view/topics_error_widget.dart';
import 'package:imposter/features/game/presentation/widgets/topics_selection_view/topics_grid_widget.dart';
import 'package:imposter/features/game/presentation/widgets/topics_selection_view/topics_loading_widget.dart';

class TopicsSelectionView extends StatelessWidget {
  const TopicsSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollScaffold(
      title: AppStrings.comingWithYou,

      slivers: [
        SliverPadding(
          padding: AppPadding.viewH18(context),
          sliver: const _TopicsSelectionContent(),
        ),
        const SliverToBoxAdapter(
          child: AppGap(30),
        ),
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
