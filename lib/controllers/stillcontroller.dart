import 'package:flutter/material.dart';

class StillController {
  double fontSize = 12;
  Color textColor = Colors.black54;

  void setFontSize(double size) {
    fontSize = size;
  }

  void setTextColor(Color color) {
    textColor = color;
  }

  TextStyle get textStyle {
    return TextStyle(fontSize: fontSize, color: textColor);
  }

  double headerFontSize = 13;
  Color headerTextColor = Colors.black87;
  FontWeight headerFontWeight = FontWeight.bold;

  void setheaderFontSize(double size) {
    headerFontSize = size;
  }

  void setheaderTextColor(Color color) {
    headerTextColor = color;
  }

  TextStyle get headerTextStyle {
    return TextStyle(
        fontSize: headerFontSize,
        color: headerTextColor,
        fontWeight: headerFontWeight);
  }
}
