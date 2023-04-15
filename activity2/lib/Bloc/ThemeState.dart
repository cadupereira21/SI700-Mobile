import 'package:flutter/material.dart';

abstract class ThemeState {
  late MaterialColor mainColor;
  late Color backgroundColor;
}

class DarkTheme extends ThemeState {
  Map<int, Color> colorMap = {100: const Color.fromRGBO(170, 49, 50, 1)};

  DarkTheme() {
    mainColor = MaterialColor(0xAA3132, colorMap);
    backgroundColor = const Color.fromRGBO(34, 34, 34, 1);
  }
}

class NormalTheme extends ThemeState {
  NormalTheme() {
    mainColor = Colors.red;
    backgroundColor = Colors.white;
  }
}
