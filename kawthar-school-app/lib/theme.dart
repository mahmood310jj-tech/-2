import 'package:flutter/material.dart';
class KawtharColors {
  static const cream = Color(0xFFFDF6E9);
  static const darkGreen = Color(0xFF2F4A3A);
  static const clay = Color(0xFFD97A4A);
  static const sandy = Color(0xFFF2D492);
  static const night = Color(0xFF1A2B22);
  static const nightCard = Color(0xFF24382E);
}
ThemeData kawtharLight() => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: KawtharColors.cream,
  colorScheme: ColorScheme.fromSeed(seedColor: KawtharColors.darkGreen, primary: KawtharColors.darkGreen, secondary: KawtharColors.clay, surface: KawtharColors.cream),
  appBarTheme: const AppBarTheme(backgroundColor: KawtharColors.darkGreen, foregroundColor: Colors.white, centerTitle: true),
);
ThemeData kawtharDark() => ThemeData(
  useMaterial3: true, brightness: Brightness.dark,
  scaffoldBackgroundColor: KawtharColors.night,
  colorScheme: ColorScheme.fromSeed(seedColor: KawtharColors.clay, brightness: Brightness.dark, primary: KawtharColors.clay, secondary: KawtharColors.sandy, surface: KawtharColors.nightCard),
  appBarTheme: const AppBarTheme(backgroundColor: KawtharColors.nightCard, foregroundColor: Colors.white, centerTitle: true),
);
