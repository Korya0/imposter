import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/constants/app_padding.dart';
import 'package:imposter/core/presentation/widgets/custom_scroll_scaffold.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';
import 'package:imposter/features/game/presentation/cubit/game_state.dart';
import 'package:imposter/features/game/presentation/widgets/game/game_view_content.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollScaffold(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: AppPadding.viewH18(context),
          sliver: SliverFillRemaining( 
            child: BlocBuilder<GameCubit, GameState>(
              builder: (context, state) => GameViewContent(state: state),
            ),
          ),
        ),
      ],
    );
  }
}
