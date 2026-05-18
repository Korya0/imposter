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
import 'package:imposter/core/style/fonts/app_text_styles.dart';
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

  Future<bool> _showDiscardConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.75),
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.secondaryBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.primary, width: 2),
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child: AppTextWidget(
            'تراجع عن الكتابة؟',
            style: AppTextStyles.font24W700Primary,
          ),
        ),
        content: AppTextWidget(
          'لو رجعت دلوقتي، كل الكلام اللي كتبته هيتمسح. متأكد إنك عايز تخرج؟',
          textAlign: TextAlign.right,
          style: AppTextStyles.font22W400White,
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          AppButton(
            height: 48,
            width: 115,
            onTap: () => Navigator.pop(dialogContext, false),
            child: AppTextWidget(
              'كمل كتابة',
              style: AppTextStyles.font18W700Primary,
            ),
          ),
          AppButton(
            height: 48,
            width: 115,
            onTap: () => Navigator.pop(dialogContext, true),
            child: AppTextWidget(
              'امسح واخرج',
              style: AppTextStyles.font18W700Primary,
            ),
          ),
        ],
      ),
    ) ?? false;
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
                canPop: !isLoading &&
                    _feedbackController.text.trim().isEmpty &&
                    _contactController.text.trim().isEmpty,
                onPopInvokedWithResult: (didPop, result) async {
                  if (didPop) return;
                  if (isLoading) return;
                  final shouldPop = await _showDiscardConfirmationDialog(context);
                  if (shouldPop && context.mounted) {
                    Navigator.pop(context);
                  }
                },
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
                      maxLines: 4,
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _contactController,
                      hintText: AppStrings.feedbackContactPlaceholder,
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: 24),
                    AppButton(
                      width: double.infinity,
                      onTap: isLoading
                          ? null
                          : () {
                              unawaited(
                                context.read<FeedbackCubit>().submitFeedback(
                                      content: _feedbackController.text,
                                      contact: _contactController.text,
                                    ),
                              );
                            },
                      title: isLoading ? null : AppStrings.sendFeedback,
                      child: isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                                strokeWidth: 2.5,
                              ),
                            )
                          : null,
                    ),
                  ],
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
      title: AppStrings.tellUs,
      child: const FeedbackBottomSheet(),
    ),
  );
}
