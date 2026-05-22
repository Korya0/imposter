import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/presentation/controller/game_setup_cubit/game_setup_cubit.dart';

class TopicsErrorWidget extends StatelessWidget {
  const TopicsErrorWidget({required this.message, super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: context.p(40),
      children: [
        const AppGap(90),
        Column(
          spacing: context.p(12),

          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: context.s(64),
              color: AppColors.primary,
            ),
            AppTextWidget(
              message,
              maxLines: 4,
            ),
          ],
        ),

        AppButton(
          title: AppStrings.tryAgain,
          width: context.w(240),
          onTap: () {
            context.read<GameSetupCubit>().init();
          },
        ),
      ],
    );
  }
}
