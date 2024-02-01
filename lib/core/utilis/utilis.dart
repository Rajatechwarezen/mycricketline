import 'package:flutter/services.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';

class MyUtils{

  static void splashScreenUtils(){
    SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
      statusBarColor: MyColor.myprimaryColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: MyColor.myprimaryColor,
      systemNavigationBarIconBrightness: Brightness.light)
    );
  }

  static void allScreensUtils(bool isDark){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyColor.getPrimaryColor(),
        statusBarIconBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: MyColor.getScreenBgColor(),
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark
      )
    );
  }
}