import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    int? value = int.tryParse(hexColor, radix: 16);
    if (value == null) {
      return int.parse("FF000000", radix: 16);
    } else {
      return value;
    }
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
