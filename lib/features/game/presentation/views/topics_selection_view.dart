import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/constants/app_padding.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/custom_scroll_scaffold.dart';
import 'package:imposter/features/game/presentation/controller/game_setup_cubit/game_setup_cubit.dart';
import 'package:imposter/features/game/presentation/controller/game_setup_cubit/game_setup_state.dart';
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
      ],
    );
  }
}

class _TopicsSelectionContent extends StatelessWidget {
  const _TopicsSelectionContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameSetupCubit, GameSetupState>(
      buildWhen: (previous, current) {
        if (previous.categories != current.categories) return true;
        return previous.runtimeType != current.runtimeType;
      },
      builder: (context, state) {
        return switch (state) {
          GameSetupInitial() || GameSetupLoading(categories: []) =>
            const SliverToBoxAdapter(child: TopicsLoadingWidget()),
          GameSetupError(message: final msg, categories: []) => SliverToBoxAdapter(
            child: TopicsErrorWidget(message: msg),
          ),
          GameSetupLoaded(categories: final cats) ||
          GameSetupLoading(categories: final cats) ||
          GameSetupError(categories: final cats) =>
            TopicsGridWidget(categories: cats),
        };
      },
    );
  }
}
