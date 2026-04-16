import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';
import 'package:imposter/features/game/presentation/cubit/game_state.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_view_body.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          return GameViewBody(currentState: state);
        },
      ),
    );
  }
}
