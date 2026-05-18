import 'package:flutter/material.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';

class TopicsErrorWidget extends StatelessWidget {
  const TopicsErrorWidget({required this.message, super.key});
  final String message;

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
