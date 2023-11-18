import 'package:flutter/material.dart';
import 'package:meus_gastos/themes/colors.dart';

final _colors = ColorsApp();

/// Tema escuro da aplicação.
final themeDark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: _colors.primary,
  colorScheme: ColorScheme.fromSeed(
    seedColor: _colors.primary,
    secondary: _colors.secondary,
  ),
  primarySwatch: Colors.green,
  scaffoldBackgroundColor: _colors.backgroundScreen,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: _colors.onPrimary,
      backgroundColor: _colors.primary,
      padding: const EdgeInsets.all(8),
    ),
  ),
);
