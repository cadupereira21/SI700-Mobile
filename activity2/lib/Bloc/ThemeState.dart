import 'package:flutter/material.dart';

abstract class ThemeState {
  late Color mainColor;
  late Color backgroundColor;
}

class DarkTheme extends ThemeState {
  DarkTheme() {
    mainColor = const Color.fromARGB(255, 170, 49, 50);
    backgroundColor = Colors.black87;
  }
}

class NormalTheme extends ThemeState {
  NormalTheme() {
    mainColor = const Color.fromARGB(255, 255, 0, 0);
    backgroundColor = Colors.white;
  }
}
