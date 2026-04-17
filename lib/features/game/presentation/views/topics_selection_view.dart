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
          BlocBuilder<GameCubit, GameState>(
            builder: (context, state) {
              return switch (state) {
                GameInitial() ||
                GameLoading(categories: []) => const TopicsLoadingWidget(),
                GameError(message: final msg, categories: []) =>
                  TopicsErrorWidget(message: msg),
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
          ),
        ],
      ),
    );
  }
}
