import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:meus_gastos/main.dart';

class AppSnackBar {
  static final AppSnackBar _instance = AppSnackBar._internal();
  AppSnackBar._internal();

  factory AppSnackBar() {
    return _instance;
  }

  void snack(String message) {
    scaffoldMessengerKey.currentState!.clearSnackBars();

    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
          vertical: 16,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        content: AutoSizeText(
          message,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
