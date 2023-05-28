import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/custom_material_color.dart';

const Color blueishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const Color primaryClr = blueishClr;
const Color darkGreyClr = Color(0xFF121212);
MaterialColor primaryClrMat =
    MaterialColor(0xFF4e5ae8, CustomMaterialColor.customSwatch(255, 78, 90));
MaterialColor darkGreyClrMat =
    MaterialColor(0xFF121212, CustomMaterialColor.customSwatch(255, 18, 18));

class Themes {
  static final light = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      backgroundColor: Colors.white,
    ),
    primaryColor: primaryClr,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      backgroundColor: darkGreyClr,
      brightness: Brightness.dark,
      primarySwatch: darkGreyClrMat,
    ),
    primaryColor: darkGreyClr,
    brightness: Brightness.dark,
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.grey[400] : Colors.grey,
  ));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  ));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  ));
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
  ));
}
