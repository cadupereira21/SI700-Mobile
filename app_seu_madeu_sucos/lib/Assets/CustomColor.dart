import 'package:flutter/material.dart';

class CustomColor extends MaterialColor {

  const CustomColor(primary, swatch) : super(primary, swatch);

  static getGreenColor() {
    int primary = 0xFF43A047;
    Map<int, Color> swatch = {
      50: const Color.fromRGBO(67, 160, 71, 1),
      100: const Color.fromRGBO(67, 160, 71, .2),
      200: const Color.fromRGBO(67, 160, 71, .3),
      300: const Color.fromRGBO(67, 160, 71, .4),
      400: const Color.fromRGBO(67, 160, 71, .5),
      500: const Color.fromRGBO(67, 160, 71, .6),
      600: const Color.fromRGBO(67, 160, 71, .7),
      700: const Color.fromRGBO(67, 160, 71, .8),
      800: const Color.fromRGBO(67, 160, 71, .9),
      900: const Color.fromRGBO(67, 160, 71, 1),
    };
    return CustomColor(primary, swatch);
  }
}
