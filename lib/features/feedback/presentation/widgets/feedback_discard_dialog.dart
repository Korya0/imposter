import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class FeedbackDiscardDialog extends StatelessWidget {
  const FeedbackDiscardDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.secondaryBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.p(16)),
        side: BorderSide(
          color: AppColors.primary,
          width: context.s(2),
        ),
      ),
      title: Align(
        alignment: Alignment.centerRight,
        child: AppTextWidget(
          AppStrings.discardFeedbackTitle,
          style: AppTextStyles.font24W700Primary,
        ),
      ),
      content: AppTextWidget(
        AppStrings.discardFeedbackMessage,
        textAlign: TextAlign.right,
        style: AppTextStyles.font22W400White,
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        AppButton(
          height: context.h(48),
          width: context.w(115),
          onTap: () => Navigator.pop(context, false),
          child: AppTextWidget(
            AppStrings.continueWriting,
            style: AppTextStyles.font18W700Primary,
          ),
        ),
        AppButton(
          height: context.h(48),
          width: context.w(115),
          onTap: () => Navigator.pop(context, true),
          child: AppTextWidget(
            AppStrings.discardAndExit,
            style: AppTextStyles.font18W700Primary,
          ),
        ),
      ],
    );
  }
}
