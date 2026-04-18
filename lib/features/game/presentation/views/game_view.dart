import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/presentation/widgets/custom_app_bar.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';
import 'package:imposter/features/game/presentation/cubit/game_state.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_view_content.dart';

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
              child: GameViewContent(state: currentState),
            ),
          ],
        ),
      ),
    );
  }
}
