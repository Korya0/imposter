import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_text_field.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/presentation/widgets/tactile_sketchy_icon_button.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/app_validators.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/presentation/controller/game_setup_cubit/game_setup_cubit.dart';
import 'package:imposter/features/game/presentation/controller/game_setup_cubit/game_setup_state.dart';

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
      builder: (context, state) {
        _syncControllers(state.playerNames);
        return Column(
          mainAxisSize: MainAxisSize.min,
          spacing: context.p(14),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  spacing: context.p(8),
                  children: [
                    SvgPicture.asset(
                      AppAssets.peopleGroupSvg,
                      height: context.h(24),
                      colorFilter: const ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    AppTextWidget(
                      AppStrings.numberOfPlayers,
                      style: AppTextStyles.font24W700Primary,
                    ),
                  ],
                ),
                _ActionButtonsRow(count: state.playerNames.length),
              ],
            ),
            ...List.generate(
              (state.playerNames.length + 1) ~/ 2,
              (rowIndex) {
                final firstIndex = rowIndex * 2;
                final secondIndex = rowIndex * 2 + 1;
                final hasSecond = secondIndex < state.playerNames.length;

                return Row(
                  spacing: context.p(12),
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: _controllers[firstIndex],
                        hintText: '${AppStrings.playerNameHint} ${firstIndex + 1}',
                        focusNode: _focusNodes[firstIndex],
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            AppValidators.alphanumericWithSpaces,
                          ),
                          LengthLimitingTextInputFormatter(12),
                        ],
                      ),
                    ),
                    if (hasSecond)
                      Expanded(
                        child: AppTextField(
                          controller: _controllers[secondIndex],
                          hintText: '${AppStrings.playerNameHint} ${secondIndex + 1}',
                          focusNode: _focusNodes[secondIndex],
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              AppValidators.alphanumericWithSpaces,
                            ),
                            LengthLimitingTextInputFormatter(12),
                          ],
                        ),
                      )
                    else
                      const Expanded(child: SizedBox()), // Placeholder for grid alignment
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

class _ActionButtonsRow extends StatelessWidget {
  const _ActionButtonsRow({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameSetupCubit>();
    return Row(
      spacing: context.p(12),
      children: [
        Row(
          children: [
            TactileSketchyIconButton(
              icon: Icons.remove_sharp,
              color: AppColors.primary,
              onPressed: count > 3 ? cubit.removePlayer : null,
            ),
          ],
        ),
        TactileSketchyIconButton(
          icon: Icons.add_sharp,
          color: AppColors.primary,
          onPressed: count < 12 ? cubit.addPlayer : null,
        ),
      ],
    );
  }
}
