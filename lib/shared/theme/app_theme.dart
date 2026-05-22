import 'package:flutter/material.dart';

ThemeData buildTheme() {
  const primary = Color(0xFF1F3B73);
  const accent = Color(0xFFF3A712);

  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: primary, secondary: accent),
    useMaterial3: true,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
    ),
  );
}
