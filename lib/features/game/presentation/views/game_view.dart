import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
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
  const _GameViewBody({
    required this.currentState,
  });
  final GameState currentState;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.p(18)).add(
          EdgeInsets.only(bottom: context.p(24) * 2),
        ),
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
