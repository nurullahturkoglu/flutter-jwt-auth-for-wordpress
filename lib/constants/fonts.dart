import 'package:flutter/material.dart';

class AppFonts {
  static const String fontName = 'Roboto';
  static const double smallSize = 14.0;
  static const double mediumSize = 17.0;
  static const double largeSize = 23.0;

  static TextStyle? small({Color color = Colors.white}) {
    return TextStyle(
      fontFamily: fontName,
      fontSize: smallSize,
      color: color,
    );
  }

  static TextStyle? large({Color color = Colors.white}) {
    return TextStyle(
      fontFamily: fontName,
      fontSize: largeSize,
      color: color,
    );
  }

  static TextStyle? medium({Color color = Colors.white}) {
    return TextStyle(
      fontFamily: fontName,
      fontSize: mediumSize,
      color: color,
    );
  }
}
