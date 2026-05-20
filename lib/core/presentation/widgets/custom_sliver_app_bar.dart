import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/presentation/widgets/app_back_button.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

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
    final canPop = showBackButton ?? Navigator.canPop(context);

    return SliverAppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floating: floating,
      snap: snap,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: context.h(60),
      leadingWidth: context.w(70),
      leading: canPop
          ? Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: context.p(10),
                ),
                child: AppBackButton(
                  onTap: onBackTap ?? () => context.pop(),
                ),
              ),
            )
          : null,
      title: title != null
          ? Text(
              title!,
              style: AppTextStyles.font24W700Primary,
              textAlign: TextAlign.center,
            )
          : null,
      actions: actions != null
          ? [
              Padding(
                padding: EdgeInsetsDirectional.only(
                  end: context.p(10),
                ),
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
