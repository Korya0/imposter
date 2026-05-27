import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/painters/sketchy_input_painter.dart';
import 'package:imposter/core/presentation/widgets/app_text_field.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/app_validators.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/presentation/controller/game_setup_cubit/game_setup_cubit.dart';
import 'package:imposter/features/game/presentation/controller/game_setup_cubit/game_setup_state.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:imposter/features/game/presentation/widgets/game_settings/game_setting_header.dart';

class PlayerNamesManagementCard extends StatefulWidget {
  const PlayerNamesManagementCard({super.key});

  @override
  State<PlayerNamesManagementCard> createState() =>
      _PlayerNamesManagementCardState();
}

class _PlayerNamesManagementCardState extends State<PlayerNamesManagementCard> {
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];

  void _syncControllers(List<String> names) {
    while (_controllers.length < names.length) {
      final index = _controllers.length;
      final controller = TextEditingController(text: names[index]);
      controller.addListener(() {
        context.read<GameSetupCubit>().updatePlayerName(index, controller.text);
      });
      _controllers.add(controller);
      _focusNodes.add(FocusNode());
    }
    while (_controllers.length > names.length) {
      _controllers.removeLast().dispose();
      _focusNodes.removeLast().dispose();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameSetupCubit, GameSetupState>(
      buildWhen: (previous, current) =>
          previous.playerNames.length != current.playerNames.length,
      builder: (context, state) {
        _syncControllers(state.playerNames);
        return Column(
          spacing: context.p(16),
          children: [
            // Player Count Control Widget
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const GameSettingHeader(
                  iconAsset: AppAssets.peopleGroupSvg,
                  title: AppStrings.numberOfPlayers,
                ),
                _ControlWidget(count: state.playerNames.length),
              ],
            ),

            // Player Names Inputs Grid
            ...List.generate(
              (state.playerNames.length + 1) ~/ 2,
              (rowIndex) {
                final firstIndex = rowIndex * 2;
                final secondIndex = rowIndex * 2 + 1;
                final totalItems = state.playerNames.length;

                return Row(
                  spacing: context.p(12),
                  children: [
                    Expanded(
                      child: _PlayerGridItem(
                        index: firstIndex,
                        totalItems: totalItems,
                        controller: firstIndex < totalItems
                            ? _controllers[firstIndex]
                            : null,
                        focusNode: firstIndex < totalItems
                            ? _focusNodes[firstIndex]
                            : null,
                      ),
                    ),
                    Expanded(
                      child: _PlayerGridItem(
                        index: secondIndex,
                        totalItems: totalItems,
                        controller: secondIndex < totalItems
                            ? _controllers[secondIndex]
                            : null,
                        focusNode: secondIndex < totalItems
                            ? _focusNodes[secondIndex]
                            : null,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _PlayerGridItem extends StatelessWidget {
  const _PlayerGridItem({
    required this.index,
    required this.totalItems,
    required this.controller,
    required this.focusNode,
  });

  final int index;
  final int totalItems;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    if (index < totalItems) {
      return AppTextField(
        iconWidget: const Icon(
          Icons.person_2_outlined,
          color: AppColors.primary,
        ),
        controller: controller!,
        hintText: '${AppStrings.playerNameHint} ${index + 1}',
        focusNode: focusNode,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            AppValidators.alphanumericWithSpaces,
          ),
          LengthLimitingTextInputFormatter(10),
        ],
      )
          .animate()
          .fadeIn(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
          )
          .scale(
            begin: const Offset(0.9, 0.9),
            end: const Offset(1, 1),
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutBack,
          );
    } else {
      return const SizedBox();
    }
  }
}

class _ControlWidget extends StatelessWidget {
  const _ControlWidget({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameSetupCubit>();
    return SizedBox(
      width: context.w(130),
      height: context.h(46),
      child: CustomPaint(
        painter: SketchyInputPainter(
          color: AppColors.primary,
          fillColor: AppColors.secondaryBackground,
          strokeWidth: 1.8,
        ),
        child: Row(
          children: [
            // Remove Button (Person -) on the left
            Expanded(
              child: GestureDetector(
                onTap: count > 3 ? cubit.removePlayer : null,
                behavior: HitTestBehavior.opaque,
                child: Icon(
                  Icons.person_remove_alt_1_sharp,
                  color: count > 3
                      ? AppColors.primary
                      : AppColors.primary.withValues(alpha: 0.4),
                  size: context.s(26),
                ),
              ),
            ),
            // Divider Line
            Container(
              width: 1.5,
              height: context.h(30),
              color: AppColors.primary.withValues(alpha: 0.4),
            ),
            // Add Button (Person +) on the right
            Expanded(
              child: GestureDetector(
                onTap: count < 12 ? cubit.addPlayer : null,
                behavior: HitTestBehavior.opaque,
                child: Icon(
                  Icons.person_add_alt_1_sharp,
                  color: count < 12
                      ? AppColors.primary
                      : AppColors.primary.withValues(alpha: 0.4),
                  size: context.s(26),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
