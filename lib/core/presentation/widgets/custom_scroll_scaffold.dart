import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/widgets/custom_sliver_app_bar.dart';

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
          ...slivers,
        ],
      ),
    );
  }
}
