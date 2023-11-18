import 'package:flutter/material.dart';

/// Classe que centraliza as cores do App para os mais diferentes acessos.
class ColorsApp {
  final Color primary = Colors.green.shade800;
  final Color secondary = Colors.purple;
  final Color onPrimary = Colors.white;
  final Color onSecondary = Colors.white;
  final Color backgroundScreen = Colors.grey.shade200;

  static final _instance = ColorsApp._init();

  factory ColorsApp() {
    return _instance;
  }

  ColorsApp._init();
}
