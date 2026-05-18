import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/di/di.dart';
import 'package:imposter/core/presentation/widgets/app_bottom_sheet/app_bottom_sheet.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_text_field.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/presentation/widgets/app_toast.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
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
      child: BlocListener<FeedbackCubit, FeedbackState>(
        listener: (context, state) {
          if (state is FeedbackSuccess) {
            AppToast.show(context, AppStrings.feedbackSuccess);
            Navigator.pop(context);
          } else if (state is FeedbackError) {
            AppToast.show(context, state.message);
          }
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: context.p(24)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Align(
                alignment: Alignment.centerRight,
                child: AppTextWidget(
                  'رأيك بيساعدنا نطور اللعبة ونخليها أحسن! اكتب مقترحك أو لو قابلتك مشكلة.',
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _feedbackController,
                hintText: AppStrings.feedbackPlaceholder,
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _contactController,
                hintText: AppStrings.feedbackContactPlaceholder,
              ),
              const SizedBox(height: 24),
              BlocBuilder<FeedbackCubit, FeedbackState>(
                buildWhen: (previous, current) =>
                    current is FeedbackLoading || previous is FeedbackLoading || current is FeedbackInitial,
                builder: (context, state) {
                  return AppButton(
                    width: double.infinity,
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
                    title: state is FeedbackLoading
                      ? null
                      : AppStrings.sendFeedback,
                    child: state is FeedbackLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: AppColors.secondary,
                              strokeWidth: 2.5,
                            ),
                          )
                        : null,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showFeedbackBottomSheet(BuildContext context) {
  unawaited(
    AppBottomSheet.show(
      context: context,
      title: AppStrings.tellUs,
      child: const FeedbackBottomSheet(),
    ),
  );
}
