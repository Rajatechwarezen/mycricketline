
import 'package:flutter/material.dart';

import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/style.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Inter',
  primaryColor: MyColor.getPrimaryColor(),
  brightness: Brightness.light,
  scaffoldBackgroundColor: MyColor.getScreenBgColor(),
  hintColor: MyColor.myhintTextColor,
  focusColor: MyColor.myfieldEnableBorderColor,
  buttonTheme: ButtonThemeData(
    buttonColor: MyColor.getPrimaryColor(),
  ),
  cardColor: MyColor.mycardBgColor,
  appBarTheme: AppBarTheme(
    backgroundColor: MyColor.getAppbarBgColor(),
    elevation: 0,
    titleTextStyle: interRegularLarge.copyWith(color: MyColor.mycolorWhite),
    iconTheme: const IconThemeData(
      size: 20,
      color: MyColor.mycolorWhite
    )
  ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(MyColor.mycolorWhite),
      fillColor: MaterialStateProperty.all(MyColor.mycolorWhite),
      overlayColor: MaterialStateProperty.all(MyColor.greenSuccessColor),
    ));