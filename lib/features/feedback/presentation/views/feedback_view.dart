import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_padding.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/presentation/widgets/custom_scroll_scaffold.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/feedback/presentation/widgets/feedback_form.dart';

class FeedbackView extends StatelessWidget {
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollScaffold(
      title: AppStrings.tellUs,
      slivers: [
        const SliverToBoxAdapter(
          child: AppGap(24),
        ),
        SliverPadding(
          padding: AppPadding.viewH18(context),
          sliver: const SliverFillRemaining(
            hasScrollBody: false,
            child: FeedbackForm(),
          ),
        ),
        if (context.isLandscape)
          const SliverToBoxAdapter(
            child: AppGap(40),
          ),
      ],
    );
  }
}
