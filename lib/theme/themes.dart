import 'package:flutter/material.dart';
import 'package:todo/theme/colors.dart';

class Themes {
  static ThemeData lightTheme() {
    return ThemeData.light(
      useMaterial3: true,
    ).copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: ThemeColors.base,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(centerTitle: true),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData.dark(
      useMaterial3: true,
    ).copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: ThemeColors.base,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(centerTitle: true),
    );
  }
}

class ThemeColors {
  static const Color base = ColorPallete.blueLight;
}
