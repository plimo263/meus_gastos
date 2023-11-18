import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meus_gastos/themes/colors.dart';

/// Tema claro com configurações

final _colors = ColorsApp();

final themeLight = ThemeData(
  brightness: Brightness.light,
  primaryColor: _colors.primary,
  colorScheme: ColorScheme.fromSeed(
    seedColor: _colors.primary,
    secondary: _colors.secondary,
  ),
  primarySwatch: Colors.green,
  scaffoldBackgroundColor: _colors.backgroundScreen,
  fontFamily: GoogleFonts.inter().fontFamily,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: _colors.onPrimary,
      backgroundColor: _colors.primary,
      padding: const EdgeInsets.all(8),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.green,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white54,
  ),
);
