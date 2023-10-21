import 'package:flutter/material.dart';
import 'package:meus_gastos/themes/colors.dart';

final theme = ThemeData(
  primaryColor: primaryColor,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: Colors.white,
    secondary: secondaryColor,
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    background: colorBackground,
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: primaryColor,
    selectedItemColor: Colors.black,
  ),
);
