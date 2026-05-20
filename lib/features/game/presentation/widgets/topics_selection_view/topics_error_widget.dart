import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';

class TopicsErrorWidget extends StatelessWidget {
  const TopicsErrorWidget({required this.message, super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: context.p(60),
          horizontal: context.p(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: context.s(64),
              color: AppColors.primary,
            ),
            const AppGap(16),
            AppTextWidget(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.font22W400Primary,
            ),
            const AppGap(32),
            AppButton(
              title: AppStrings.tryAgain,
              width: context.w(180),
              height: context.h(55),
              onTap: () {
                context.read<GameCubit>().init();
              },
            ),
          ],
        ),
      ),
    );
  }
}
