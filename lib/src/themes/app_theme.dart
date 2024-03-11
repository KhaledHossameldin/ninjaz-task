import 'package:flutter/material.dart';

import 'extensions.dart';

class AppTheme {
  final main = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    chipTheme: ChipThemeData(
      side: BorderSide.none,
      backgroundColor: Colors.red,
      padding: EdgeInsets.symmetric(
        vertical: 2.height,
        horizontal: 4.width,
      ),
      labelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
