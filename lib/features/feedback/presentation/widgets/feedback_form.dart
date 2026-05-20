import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/presentation/widgets/app_loading_indicator.dart';
import 'package:imposter/core/presentation/widgets/app_text_field.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/feedback/presentation/cubit/feedback_cubit.dart';

class FeedbackForm extends StatelessWidget {
  final TextEditingController feedbackController;
  final TextEditingController contactController;
  final bool isLoading;

  const FeedbackForm({
    required this.feedbackController,
    required this.contactController,
    required this.isLoading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Align(
          alignment: Alignment.centerRight,
          child: AppTextWidget(
            AppStrings.feedbackSubtitle,
            textAlign: TextAlign.right,
          ),
        ),
        const AppGap(16),
        AppTextField(
          controller: feedbackController,
          hintText: AppStrings.feedbackPlaceholder,
          maxLines: 4,
          enabled: !isLoading,
        ),
        const AppGap(16),
        AppTextField(
          controller: contactController,
          hintText: AppStrings.feedbackContactPlaceholder,
          enabled: !isLoading,
        ),
        const AppGap(24),
        AppButton(
          width: double.infinity,
          onTap: isLoading
              ? null
              : () {
                  unawaited(
                    context.read<FeedbackCubit>().submitFeedback(
                          content: feedbackController.text,
                          contact: contactController.text,
                        ),
                  );
                },
          title: isLoading ? null : AppStrings.sendFeedback,
          child: isLoading
              ? AppLoadingIndicator(
                  size: context.s(24),
                  color: AppColors.secondary,
                )
              : null,
        ),
      ],
    );
  }
}
