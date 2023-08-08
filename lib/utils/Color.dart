import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import '../AipProvider/ThemeProvider.dart';

class CustomColor {
  static final LocalStorage storage = LocalStorage('my_theme_storage');

  static BuildContext get context => context;
  static var themeProvider;
  static var mytheam;
  static Future<void> initStorage() async {
    await storage.ready;
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    mytheam = themeProvider.isDarkTheme;
  }

  static final Color cricketWhite = Colors.white;
  static Color cricketAppBackground = Color(0xFFf3f5f9);
  static const Color cricketBlackColor = Color(0xFF000000);
  static const Color cricketPrimary = Color(0xFF232883);
  static const Color cricketGradientColor1 = Color.fromARGB(255, 167, 40, 23);
  static const Color cricketGradientColor2 = Color(0xFF2b33bf);
  static Color cricketTextColorPrimary = Colors.white;
  static Color cricketTextColorSecondary =
      const Color.fromARGB(255, 214, 209, 209);
  static const Color cricketShadowColor = Color(0X95E9EBF0);
  static const Color cricketColor1 = Color(0xFF8f93d6);
  static const Color cricketSkyBlueColor = Color(0xFF65f7ff);

  static const Color cricketBlackColor3 = Color.fromARGB(255, 35, 90, 5);

  // New set of colors for dark mode
  static const Color cricketDarkWhite = Color(0xFF1E1E1E);
  static const Color cricketDarkPrimary = Color(0xFFA7A7A7);
  static const Color cricketDarkGradientColor2 = Color(0xFF1E90FF);

  static const Color cricketDarkTextColorPrimary = Color(0xFFFFFFFF);
  static const Color cricketDarkTextColorSecondary =
      Color.fromARGB(255, 100, 100, 100);
  static const Color cricketDarkShadowColor = Color(0X95000000);
  static const Color cricketDarkColor1 = Color(0xFF6E6E6E);
  static const Color cricketDarkSkyBlueColor = Color(0xFF00CED1);
  static const Color cricketDarkAppBackground = Color(0xFF121212);
  static const Color cricketDarkBlackColor = Color(0xFFCCCCCC);
  static const Color cricketDarkBlackColor3 = Color.fromARGB(255, 5, 30, 90);
}
