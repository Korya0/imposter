import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/di/di.dart';
import 'package:imposter/core/presentation/widgets/app_bottom_sheet/app_bottom_sheet.dart';
import 'package:imposter/core/presentation/widgets/app_toast.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/feedback/presentation/cubit/feedback_cubit.dart';
import 'package:imposter/features/feedback/presentation/widgets/feedback_discard_dialog.dart';
import 'package:imposter/features/feedback/presentation/widgets/feedback_form.dart';

class FeedbackBottomSheet extends StatefulWidget {
  const FeedbackBottomSheet({super.key});

  @override
  State<FeedbackBottomSheet> createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet> {
  final _feedbackController = TextEditingController();
  final _contactController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  Future<bool> _showDiscardConfirmation(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierColor: Colors.black.withValues(alpha: 0.75),
          builder: (dialogContext) => const FeedbackDiscardDialog(),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FeedbackCubit>(),
      child: BlocListener<FeedbackCubit, FeedbackState>(
        listener: (context, state) {
          if (state is FeedbackSuccess) {
            AppToast.show(context, AppStrings.feedbackSuccess);
            Navigator.pop(context);
          } else if (state is FeedbackError) {
            AppToast.show(context, state.message);
          }
        },
        child: BlocBuilder<FeedbackCubit, FeedbackState>(
          builder: (context, state) {
            final isLoading = state is FeedbackLoading;
            return Padding(
              padding: EdgeInsets.only(bottom: context.p(24)),
              child: PopScope(
                canPop:
                    !isLoading &&
                    _feedbackController.text.trim().isEmpty &&
                    _contactController.text.trim().isEmpty,
                onPopInvokedWithResult: (didPop, result) async {
                  if (didPop || isLoading) return;
                  final shouldPop = await _showDiscardConfirmation(context);
                  if (shouldPop && context.mounted) Navigator.pop(context);
                },
                child: FeedbackForm(
                  feedbackController: _feedbackController,
                  contactController: _contactController,
                  isLoading: isLoading,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void showFeedbackBottomSheet(BuildContext context) {
  unawaited(
    AppBottomSheet.show(
      context: context,
      title: AppStrings.dontLetHopeDown,
      child: const FeedbackBottomSheet(),
    ),
  );
}
