import 'package:flutter/material.dart';

class TColor {
  static Color get primary => const Color(0x00fff7aa);
  static Color get primaryText => const Color(0xff4A4B4D);
  static Color get secondaryText => const Color(0xff7C7D7E);
  static Color get textfield => const Color(0xffF2F2F2);
  static Color get placeholder => const Color(0xffB6B7B7);
  static Color get white => const Color(0xffffffff);
  static Color get bgButtonPrimary => const Color.fromARGB(255, 35, 48, 193);
  static Color get bgHeaderPrimary => const Color.fromARGB(255, 146, 170, 100);
  static Color get bgAppPrimary => const Color.fromARGB(228, 164, 207, 100);

  static const primaryColor1 = Color.fromARGB(255, 50, 199, 99);
  static const primaryColor2 = Color.fromARGB(255, 56, 118, 253);

  static const secondaryColor1 = Color.fromARGB(255, 98, 142, 255);
  static const secondaryColor2 = Color(0xFF9DCEFF);

  static const whiteColor = Color(0xFFFFFFFF);
  static const blackColor = Color(0xFF1D1617);
  static const grayColor = Color(0xFF7B6F72);
  static const lightGrayColor = Color(0xFFF7F8F8);
  static const midGrayColor = Color(0xFFADA4A5);

  static List<Color> get primaryG => [primaryColor1, primaryColor2];
  static List<Color> get secondaryG => [secondaryColor1, secondaryColor2];
}
