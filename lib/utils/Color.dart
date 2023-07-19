import 'package:flutter/material.dart';

const Cricket_white = Color(0xFFffffff);
const Cricket_Primary = Color(0xFF232883);
const Cricket_Gradient_color1 = Color.fromARGB(255, 167, 40, 23);
const Cricket_Gradient_color2 = Color(0xFF2b33bf);

const Cricket_textColorPrimary = Color(0xFF333333);
const Cricket_textColorSecondary = Color.fromARGB(255, 214, 209, 209);
const Cricket_ShadowColor = Color(0X95E9EBF0);
const Cricket_color1 = Color(0xFF8f93d6);
const Cricket_SkyBlue_Color = Color(0xFF65f7ff);
const Cricket_app_Background = Color(0xFFf3f5f9);
const Cricket_BlackColor = Color(0xFF000000);
const Cricket_BlackColor3 = Color.fromARGB(255, 35, 90, 5);

ThemeData buildLightTheme() {
  return ThemeData(
      // primaryColor: Cricket_Primary,
      // hintColor: Cricket_Gradient_color1,
      // scaffoldBackgroundColor: Cricket_Gradient_color2,
      // textTheme: TextTheme(
      //   bodyText1: TextStyle(color: Cricket_textColorPrimary),
      //   bodyText2: TextStyle(color: Cricket_textColorSecondary),
      //),
      );
}

ThemeData buildDarkTheme() {
  return ThemeData(
      // primaryColor: Cricket_Primary,
      // hintColor: Cricket_Gradient_color1,
      // scaffoldBackgroundColor: Cricket_BlackColor,
      // textTheme: TextTheme(
      //   bodyText1: TextStyle(color: Cricket_textColorPrimary),
      //   bodyText2: TextStyle(color: Cricket_textColorSecondary),
      // ),
      );
}
