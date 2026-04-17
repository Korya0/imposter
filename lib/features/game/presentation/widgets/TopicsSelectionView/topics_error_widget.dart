import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';

class TopicsErrorWidget extends StatelessWidget {
  final String message;
  const TopicsErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: AppTextWidget(message),
      ),
    );
  }
}
