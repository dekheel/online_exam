import 'package:flutter/material.dart';

abstract class AppColors {
  static MaterialColor blue = MaterialColor(0XFF02369C, {
    10: Color(0xffccd7eb),
    20: Color(0xffabbcde),
    30: Color(0xff819bce),
    40: Color(0xff5679bd),
    50: Color(0xff2c58ad),
    60: Color(0xff022d82),
    70: Color(0xff012468),
    80: Color(0xff011b4e),
    90: Color(0xff011234),
    100: Color(0xff000b1f),
  });

  static MaterialColor black = MaterialColor(0XFF0f0f0f, {
    10: Color(0xffcfcfcf),
    20: Color(0xffafafaf),
    30: Color(0xff878787),
    40: Color(0xff5f5f5f),
    50: Color(0xff373737),
    60: Color(0xff0d0d0d),
    70: Color(0xff0a0a0a),
    80: Color(0xff080808),
    90: Color(0xff050505),
    100: Color(0xff030303),
  });

  static Color green = const Color(0XFF11CE19);
  static Color red = const Color(0XFFCC1010);
  static Color grey = const Color(0XFF535353);
  static Color white = const Color(0XFFF9F9F9);
  static Color lightGrey = const Color(0XFFA6A6A6);
  static Color lightGreen = const Color(0XFFCAF9CC);
  static Color lightRed = const Color(0XFFF8D2D2);
}
