import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_padding.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_back_button.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/feedback/presentation/widgets/feedback_form.dart';

class FeedbackView extends StatelessWidget {
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            surfaceTintColor: Colors.transparent,
            floating: true,
            snap: true,
            elevation: 0,
            leading: AppBackButton(onTap: context.pop),
            title: Text(
              AppStrings.tellUs,
              style: AppTextStyles.font24W700Primary,
            ),
            centerTitle: true,
          ),
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
      ),
    );
  }
}
