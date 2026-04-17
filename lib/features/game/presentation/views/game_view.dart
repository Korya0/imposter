import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/router/app_routes.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/presentation/widgets/custom_app_bar.dart';
import 'package:imposter/core/presentation/widgets/lottie_timer.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';
import 'package:imposter/features/game/presentation/cubit/game_state.dart';
import 'package:imposter/features/game/presentation/widgets/game/citizen_reveal_view.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_fingerprint_button.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_finish_game_button.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_finish_turn_button.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_next_button.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_ready_view.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_summary_view.dart';
import 'package:imposter/features/game/presentation/widgets/game/spy_reveal_view.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          return _GameViewBody(currentState: state);
        },
      ),
    );
  }
}

class _GameViewBody extends StatelessWidget {
  final GameState currentState;

  const _GameViewBody({
    required this.currentState,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: AppPaddings.h18.add(AppPaddings.bottomPaddingH05(context) * 2),
        child: Column(
          children: [
            const CustomAppBar(),
            Expanded(
              child: _buildCurrentStateContent(context),
            ),
            _buildBottomAction(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStateContent(BuildContext context) {
    final cubit = context.read<GameCubit>();

    return switch (currentState) {
      GameInitial() ||
      GameLoading() => const Center(child: CircularProgressIndicator()),
      GameCategoriesLoaded() => const Center(
          child: AppTextWidget(AppStrings.comingSoon),
        ),
      GameScanning(currentPlayerIndex: final index) => _ScanViewBody(
          playerNumber: index + 1,
        ),
      GameRevealing(isSpy: final spy, secretWord: final word, selectedCategory: final cat) =>
        spy ? SpyRevealView(category: cat.name) : CitizenRevealView(category: cat.name, word: word),
      GameReady() => GameReadyView(onStartTimer: cubit.startTimer),
      GameTimer(durationMinutes: final mins) => LottieTimer(
          duration: Duration(minutes: mins),
          onTimeout: cubit.finishGame,
        ),
      GameSummary(
        secretWord: final word,
        playerCount: final p,
        spyCount: final s,
        durationMinutes: final d,
      ) =>
        GameSummaryView(
          secretWord: word,
          playersCount: p,
          spiesCount: s,
          duration: Duration(minutes: d),
          onAnotherRound: cubit.prepareRound,
          onFinish: () => context.goNamed(AppRoutes.home),
        ),
      GameError(message: final msg) => Center(child: AppTextWidget(msg)),
    }
        .animate(key: ValueKey(currentState))
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.05, end: 0, curve: Curves.easeOutQuad);
  }

  Widget _buildBottomAction(BuildContext context) {
    final cubit = context.read<GameCubit>();

    return switch (currentState) {
      GameScanning() => GameFingerprintButton(
          onTap: () => cubit.toggleReveal(true),
        ),
      GameRevealing() => Padding(
          padding: AppPaddings.h24,
          child: GameNextButton(onPressed: () => cubit.toggleReveal(false)),
        ),
      GameTimer() => Padding(
          padding: AppPaddings.h24,
          child: GameFinishTurnButton(onPressed: cubit.finishGame),
        ),
      GameSummary() => Padding(
          padding: AppPaddings.h24,
          child: GameFinishGameButton(
            onPressed: () => context.goNamed(AppRoutes.home),
          ),
        ),
      _ => const SizedBox.shrink(),
    };
  }
}

class _ScanViewBody extends StatelessWidget {
  final int playerNumber;

  const _ScanViewBody({required this.playerNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextWidget(
                AppStrings.player,
                style: AppTextStyles.ruqaa32W400Primary,
              ),
              AppTextWidget(
                playerNumber.toString(),
                style: AppTextStyles.ruqaa32W400Primary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
