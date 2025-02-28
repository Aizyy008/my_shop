import 'package:flutter/material.dart';

class ColorConverter {

  static Color fromHex(String hex) {
    hex = hex.replaceAll("#", "");
    if (hex.length == 6) {
      hex = "FF$hex";
    }
    return Color(int.parse("0x$hex"));
  }
}