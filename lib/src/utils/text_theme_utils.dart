import 'package:flutter/material.dart';

class TextThemeUtils {
  static const DARK_MENU_TEXT = TextStyle(
    color: Colors.black,
    fontSize: 20,
    // fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w800,
    fontFamily: "Heebo",
  );
  static const LIGHT_MENU_TEXT = TextStyle(
    color: Colors.white,
    fontSize: 21,
    fontWeight: FontWeight.w900,
    shadows: [
      Shadow(
        blurRadius: 10,
        color: Colors.black87,
        offset: Offset(0, 0),
      )
    ],
  );
}
