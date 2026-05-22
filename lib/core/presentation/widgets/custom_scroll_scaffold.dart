import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/presentation/widgets/app_back_button.dart';
import 'package:imposter/core/presentation/widgets/app_gap.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class CustomScrollScaffold extends StatelessWidget {
  const CustomScrollScaffold({
    required this.slivers,
    super.key,
    this.title,
    this.actions,
    this.onBackTap,
    this.showBackButton,
    this.physics = const BouncingScrollPhysics(),
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.appBarFloating = true,
    this.appBarSnap = true,
  });

  final String? title;
  final List<Widget> slivers;
  final List<Widget>? actions;
  final VoidCallback? onBackTap;
  final bool? showBackButton;
  final ScrollPhysics physics;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool appBarFloating;
  final bool appBarSnap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      body: CustomScrollView(
        physics: physics,
        slivers: [
          CustomSliverAppBar(
            title: title,
            actions: actions,
            onBackTap: onBackTap,
            showBackButton: showBackButton,
            floating: appBarFloating,
            snap: appBarSnap,
          ),
          const SliverToBoxAdapter(
            child: AppGap(12),
          ),
          ...slivers,
          const SliverToBoxAdapter(
            child: AppGap(40),
          ),
        ],
      ),
    );
  }
}

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    this.title,
    this.actions,
    this.onBackTap,
    this.showBackButton,
    this.floating = true,
    this.snap = true,
  });

  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackTap;
  final bool? showBackButton;
  final bool floating;
  final bool snap;

  @override
  Widget build(BuildContext context) {
    final canPop = showBackButton ?? GoRouter.of(context).canPop();

    return SliverAppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.background,
      floating: floating,
      snap: snap,
      elevation: 0,
      centerTitle: true,
      leadingWidth: context.w(64),
      leading: canPop
          ? Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: EdgeInsets.only(right: context.p(16)),
                child: AppBackButton(onTap: onBackTap ?? () => context.pop()),
              ),
            )
          : null,
      title: title != null
          ? AppTextWidget(
              title!,
            )
          : null,
      actions: actions != null
          ? [
              Padding(
                padding: EdgeInsets.only(right: context.p(16)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: context.p(8),
                  children: actions!,
                ),
              ),
            ]
          : null,
    );
  }
}
