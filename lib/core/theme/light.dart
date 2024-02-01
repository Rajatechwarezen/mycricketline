import 'package:flutter/material.dart';

import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/style.dart';

ThemeData light = ThemeData(
    fontFamily: 'Inter',
    primaryColor: MyColor.lPrimaryColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: MyColor.bgColorLight,
    hintColor: MyColor.myhintTextColor,
    buttonTheme: ButtonThemeData(
      buttonColor: MyColor.getPrimaryColor(),
    ),
    cardColor: MyColor.mycardBgColor,
    appBarTheme: AppBarTheme(
        backgroundColor: MyColor.lPrimaryColor,
        elevation: 0,
        titleTextStyle: interRegularLarge.copyWith(color: MyColor.mycolorWhite),
        iconTheme: const IconThemeData(
            size: 20,
            color: MyColor.mycolorWhite
        )
    ),
    checkboxTheme: CheckboxThemeData(
     checkColor: MaterialStateProperty.all(MyColor.mycolorBlack),
     fillColor: MaterialStateProperty.all(MyColor.myprimaryColor),

));