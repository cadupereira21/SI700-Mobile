import 'package:flutter/material.dart';

abstract class ThemeState {
  //late MaterialColor mainColor;
  late Color mainColor;
  late Color backgroundColor;
  late bool isDark;
  late MaterialColor swatch;
}

class DarkTheme extends ThemeState {

  DarkTheme() {
    //mainColor = MaterialColor(0xAA3132, colorMap);
    mainColor = Colors.brown;
    backgroundColor = const Color.fromRGBO(34, 34, 34, 1);
    swatch = Colors.brown;
    isDark = true;
  }
}

class NormalTheme extends ThemeState {
  NormalTheme() {
    mainColor = Colors.amber;
    swatch = Colors.amber;
    backgroundColor = Colors.white;
    isDark = false;
  }
}
