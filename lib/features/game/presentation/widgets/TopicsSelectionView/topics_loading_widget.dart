import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/widgets/app_loading_indicator.dart';

class TopicsLoadingWidget extends StatelessWidget {
  const TopicsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLoadingIndicator();
  }
}
