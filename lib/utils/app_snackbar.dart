import 'package:flutter/material.dart';
import 'package:meus_gastos/main.dart';

class AppSnackBar {
  static final AppSnackBar _instance = AppSnackBar._internal();
  AppSnackBar._internal();

  factory AppSnackBar() {
    return _instance;
  }

  void snack(String message) {
    scaffoldMessengerKey.currentState!
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
