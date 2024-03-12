import 'package:flutter/material.dart';

import '../../../core/themes/extensions.dart';

class ReloadWidget extends StatelessWidget {
  const ReloadWidget({super.key, required this.text, required this.onReload});

  final String text;
  final VoidCallback onReload;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(text),
      24.emptyHeight,
      ElevatedButton(
        onPressed: onReload,
        child: const Text('Reload'),
      ),
    ]);
  }
}
