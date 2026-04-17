import 'package:flutter/material.dart';
import 'package:imposter/features/game/domain/entities/category_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'topics_grid_widget.dart';

class TopicsLoadingWidget extends StatelessWidget {
  const TopicsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Creating dummy categories for skeletonizer
    final dummyCategories = List.generate(
      6,
      (index) => CategoryEntity(
        id: 'dummy_$index',
        name: '..........',
        icon: '',
        words: const [],
      ),
    );

    return Skeletonizer(
      child: TopicsGridWidget(categories: dummyCategories),
    );
  }
}
