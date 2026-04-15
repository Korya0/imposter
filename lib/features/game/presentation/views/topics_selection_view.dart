import 'package:flutter/material.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/features/game/presentation/widgets/topics_selection/topics_selection_view_body.dart';

class TopicsSelectionView extends StatelessWidget {
  const TopicsSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPaddings.h18,
          child: SingleChildScrollView(
            child: TopicsSelectionViewBody(),
          ),
        ),
      ),
    );
  }
}
