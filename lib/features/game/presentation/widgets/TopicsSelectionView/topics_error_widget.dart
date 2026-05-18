import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/features/game/presentation/cubit/game_cubit.dart';

class TopicsErrorWidget extends StatelessWidget {
  const TopicsErrorWidget({required this.message, super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              size: 64,
              color: Colors.amber,
            ),
            const SizedBox(height: 16),
            AppTextWidget(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.font22W400Primary,
            ),
            const SizedBox(height: 32),
            AppButton(
              title: 'إعادة المحاولة',
              width: 180,
              height: 55,
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
