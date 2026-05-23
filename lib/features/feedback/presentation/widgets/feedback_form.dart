import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/di/di.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/presentation/widgets/app_loading_indicator.dart';
import 'package:imposter/core/presentation/widgets/app_text_field.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/presentation/widgets/app_toast.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/feedback/presentation/cubit/feedback_cubit.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({
    super.key,
  });

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FeedbackCubit>(),
      child: BlocConsumer<FeedbackCubit, FeedbackState>(
        listener: (context, state) {
          if (state is FeedbackSuccess) {
            AppToast.show(context, AppStrings.feedbackSuccess);
            context.pop();
          } else if (state is FeedbackError) {
            AppToast.show(context, state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is FeedbackLoading;
          return Column(
            spacing: context.p(26),
            mainAxisAlignment: .spaceAround,

            children: [
              Column(
                spacing: context.p(26),
                children: [
                  AppTextWidget(
                    AppStrings.feedbackSubtitle,
                    style: AppTextStyles.font18W400White,
                  ),
                  AppTextField(
                    controller: _feedbackController,
                    hintText: AppStrings.feedbackPlaceholder,
                    maxLines: 4,
                    enabled: !isLoading,
                    textInputAction: TextInputAction.send,
                    onSubmitted: isLoading
                        ? null
                        : (_) {
                            unawaited(
                              context.read<FeedbackCubit>().submitFeedback(
                                content: _feedbackController.text,
                              ),
                            );
                          },
                  ),
                  FeedbackSubmitButton(
                    isLoading: isLoading,
                    feedbackController: _feedbackController,
                  ),
                ],
              ),
              const AppGap(0),
            ],
          );
        },
      ),
    );
  }
}

class FeedbackSubmitButton extends StatelessWidget {
  const FeedbackSubmitButton({
    required this.isLoading,
    required this.feedbackController,
    super.key,
  });

  final bool isLoading;
  final TextEditingController feedbackController;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onTap: isLoading
          ? null
          : () {
              unawaited(
                context.read<FeedbackCubit>().submitFeedback(
                  content: feedbackController.text,
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
    );
  }
}
