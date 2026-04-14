import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    kIsWeb && kDebugMode
        ? DevicePreview(builder: (context) => const ImposterApp())
        : const ImposterApp(),
  );
}

class ImposterApp extends StatelessWidget {
  const ImposterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp();
  }
}
