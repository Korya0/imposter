import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/di/di.dart';
import 'package:imposter/core/presentation/widgets/app_bottom_sheet/app_bottom_sheet.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_text_field.dart';
import 'package:imposter/core/presentation/widgets/app_toast.dart';
import 'package:imposter/features/feedback/presentation/cubit/feedback_cubit.dart';

class FeedbackBottomSheet extends StatefulWidget {
  const FeedbackBottomSheet({super.key});

  @override
  State<FeedbackBottomSheet> createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet> {
  late final TextEditingController _feedbackController;
  late final TextEditingController _contactController;

  @override
  void initState() {
    super.initState();
    _feedbackController = TextEditingController();
    _contactController = TextEditingController();
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    _contactController.dispose();
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
            Navigator.pop(context);
          } else if (state is FeedbackError) {
            AppToast.show(context, state.message);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: AppPaddings.bottomPaddingH05(context),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextField(
                  controller: _feedbackController,
                  hintText: AppStrings.feedbackPlaceholder,
                  maxLines: 7,
                ),
                const SizedBox(height: 24),
                AppButton(
                  width: double.infinity,
                  title: state is FeedbackLoading
                      ? '...'
                      : AppStrings.sendFeedback,
                  onTap: state is FeedbackLoading
                      ? null
                      : () {
                          unawaited(
                            context.read<FeedbackCubit>().submitFeedback(
                              content: _feedbackController.text,
                              contact: _contactController.text,
                            ),
                          );
                        },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void showFeedbackBottomSheet(BuildContext context) {
  unawaited(
    AppBottomSheet.show(
      context: context,
      title: AppStrings.feedbackSuggestionOrComplaint,
      child: const FeedbackBottomSheet(),
    ),
  );
}
