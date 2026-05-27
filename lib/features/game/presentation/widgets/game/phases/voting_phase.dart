import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/painters/sketchy_input_painter.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_divider.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/presentation/widgets/app_toast.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/presentation/controller/game_session_cubit/game_session_cubit.dart';

class VotingPhaseWidget extends StatefulWidget {
  const VotingPhaseWidget({required this.onFinishVoting, super.key});
  final ValueChanged<Map<int, List<int>>> onFinishVoting;

  @override
  State<VotingPhaseWidget> createState() => _VotingPhaseWidgetState();
}

class _VotingPhaseWidgetState extends State<VotingPhaseWidget> {
  final Map<int, List<int>> _votes = {};

  @override
  void initState() {
    super.initState();
    final session = context.read<GameSessionCubit>();
    for (var i = 0; i < session.playerCount; i++) {
      _votes[i] = [];
    }
  }

  void _toggleVote(int voterIndex, int targetIndex, int spyCount) {
    setState(() {
      final voterVotes = _votes[voterIndex]!;
      if (voterVotes.contains(targetIndex)) {
        voterVotes.remove(targetIndex);
      } else if (voterVotes.length < spyCount) {
        voterVotes.add(targetIndex);
      } else {
        _showWarning(
          AppStrings.maxSpiesSelectedWarning.replaceFirst('{}', '$spyCount'),
        );
      }
    });
  }

  void _showWarning(String message) {
    AppToast.show(context, message);
  }

  void _handleSubmit(GameSessionCubit session) {
    final incompleteNames = <String>[];
    for (var i = 0; i < session.playerCount; i++) {
      if (_votes[i]!.length != session.spyCount) {
        incompleteNames.add(session.playerNames[i]);
      }
    }

    if (incompleteNames.isNotEmpty) {
      _showWarning(
        AppStrings.playersNotFinishedVoting.replaceFirst(
          '{}',
          incompleteNames.join('، '),
        ),
      );
      return;
    }

    widget.onFinishVoting(_votes);
  }

  @override
  Widget build(BuildContext context) {
    final session = context.read<GameSessionCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            AppTextWidget(
              AppStrings.whoIsTheSpy,
              style: AppTextStyles.font28W700Primary,
            )
                .animate()
                .fadeIn(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOut,
                )
                .slideY(
                  begin: -0.15,
                  end: 0,
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOutQuad,
                ),
            const AppDivider(),

            VotingListWidget(
              playerCount: session.playerCount,
              votes: _votes,
              session: session,
              onVoteToggled: _toggleVote,
            ),
            const AppDivider(),
          ],
        ),

        AppButton(
          title: AppStrings.goToSummary,
          onTap: () => _handleSubmit(session),
        )
            .animate()
            .fadeIn(
              delay: const Duration(milliseconds: 400),
              duration: const Duration(milliseconds: 350),
            )
            .slideY(
              begin: 0.15,
              end: 0,
              delay: const Duration(milliseconds: 400),
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutQuad,
            ),
      ],
    );
  }
}

class VotingListWidget extends StatelessWidget {
  const VotingListWidget({
    required this.playerCount,
    required this.votes,
    required this.session,
    required this.onVoteToggled,
    super.key,
  });

  final int playerCount;
  final Map<int, List<int>> votes;
  final GameSessionCubit session;
  final void Function(int voterIndex, int targetIndex, int spyCount)
  onVoteToggled;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ...List.generate(playerCount, (index) {
            final delayIndex = index.clamp(0, 4);
            return Column(
              children: [
                VotingPlayerSection(
                  voterIndex: index,
                  votes: votes[index]!,
                  session: session,
                  onVoteToggled: (target) =>
                      onVoteToggled(index, target, session.spyCount),
                ),
                if (index < playerCount - 1) const AppDivider(),
              ],
            )
                .animate()
                .fadeIn(
                  delay: Duration(milliseconds: 150 + (delayIndex * 80)),
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOut,
                )
                .slideY(
                  begin: 0.1,
                  end: 0,
                  delay: Duration(milliseconds: 150 + (delayIndex * 80)),
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOutCubic,
                );
          }),
        ],
      ),
    );
  }
}

class VotingPlayerSection extends StatelessWidget {
  const VotingPlayerSection({
    required this.voterIndex,
    required this.votes,
    required this.session,
    required this.onVoteToggled,
    super.key,
  });

  final int voterIndex;
  final List<int> votes;
  final GameSessionCubit session;
  final ValueChanged<int> onVoteToggled;

  @override
  Widget build(BuildContext context) {
    final voterName = session.playerNames[voterIndex];
    return Column(
      spacing: context.p(6),
      children: [
        AppTextWidget(
          voterName,
          style: AppTextStyles.font24W700Primary,
        ),
        VotingTargetGrid(
          voterIndex: voterIndex,
          votes: votes,
          session: session,
          onVoteToggled: onVoteToggled,
        ),
      ],
    );
  }
}

class VotingTargetGrid extends StatelessWidget {
  const VotingTargetGrid({
    required this.voterIndex,
    required this.votes,
    required this.session,
    required this.onVoteToggled,
    super.key,
  });

  final int voterIndex;
  final List<int> votes;
  final GameSessionCubit session;
  final ValueChanged<int> onVoteToggled;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: context.p(12),
      alignment: WrapAlignment.center,
      children: List.generate(session.playerCount, (targetIndex) {
        if (targetIndex == voterIndex) return const SizedBox.shrink();
        final isSelected = votes.contains(targetIndex);
        final targetName = session.playerNames[targetIndex];

        return VotingTargetCard(
          name: targetName,
          isSelected: isSelected,
          onTap: () => onVoteToggled(targetIndex),
        );
      }),
    );
  }
}

class VotingTargetCard extends StatelessWidget {
  const VotingTargetCard({
    required this.name,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: SketchyInputPainter(
          color: AppColors.primary,
          fillColor: isSelected
              ? AppColors.primary.withValues(alpha: 0.15)
              : AppColors.secondaryBackground.withValues(alpha: 0.4),
          strokeWidth: isSelected ? 2 : 1.5,
          isFocused: isSelected,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.p(8),
            vertical: context.p(4),
          ),
          child: AppTextWidget(
            name, 
            style: isSelected
                ? AppTextStyles.font16W700Primary
                : AppTextStyles.font16W700White,
          ),
        ),
      ),
    );
  }
}
