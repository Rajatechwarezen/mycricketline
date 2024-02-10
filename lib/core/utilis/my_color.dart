import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprotbuzz/data/controller/theme_controller.dart';

class MyColor{

  static const Color myprimaryColor = Color(0xffCBA352);

  static const Color mybackgroundColor =  Color(0xff0D222B);
  static const Color mysplashBgColor =  Color(0xffCBA352);
  static const Color myappBarColor = Color(0xff192D36);

  static const Color myfieldEnableBorderColor = Color(0xffCBA352);
  static const Color myfieldDisableBorderColor = Color(0xff2C3F47);
  static const Color myfieldFillColor = Color(0xff22353E);

  /// card color
  static const Color mycardPrimaryColor = Color(0xff0D222B);
  static const Color mycardSecondaryColor = Color(0xff2C3F47);
  static const Color mycardBorderColor = Color(0xff2C3F47);
  static const Color mycardBgColor = Color(0xff192D36);

  /// text color
  static const Color myprimaryTextColor = Color(0xffffffff);
  static const Color mysecondaryTextColor = Color(0xffCBA352);
  static const Color mysmallTextColor = Color(0xffE7E9EA);
  static const Color mylabelTextColor = Color(0xffB8BEC1);
  static const Color myhintTextColor =  Color(0xFF0F6888);

  static const Color mycolorWhite = Color(0xffFFFFFF);
  static const Color mycolorBlack = Color(0xff262626);
  static const Color mycolorGrey = Color(0xff777777);
  static const Color mycolorGolden = Color(0xffCBA352);
  static const Color mytransparentColor = Colors.transparent;

  /// bottom navbar
  static const Color mybottomNavBgColor = Color(0xff233D48);
  static const Color myborderColor =Color(0xff2C3F47);

  /// shimmer color
  static const Color myshimmerBaseColor=Color(0xFF2A2E38);
  static const Color myshimmerSplashColor=Color(0xFF52575C);
  static const Color myred= Color(0xFFD92027);
  static const Color mygreen= Color(0xFF28C76F);


  // light theme color
  static const Color lScreenBgColor1 = Color(0xfff5f6fa);
  static const Color lScreenBgColor = Color(0xffE7E9EA);
  static const Color lTextColor = Color(0xff2A3962);
  static const Color lPrimaryColor = Color(0xff1F2B3A);


  /// set color for theme

  static Color getLabelTextColor(){
    return Get.find<ThemeController>().darkTheme ? mylabelTextColor : lTextColor.withOpacity(0.6);
  }
  static Color myGolden(){
    return Get.find<ThemeController>().darkTheme ? mycolorGolden : mysecondaryTextColor.withOpacity(0.6);
  }

  static Color getInputTextColor(){
    return Get.find<ThemeController>().darkTheme ? mycolorWhite : mycolorBlack;
  }

  static Color getHintTextColor(){
    return Get.find<ThemeController>().darkTheme ? myhintTextColor : mycolorBlack;
  }

  static Color getButtonColor(){
    return  myprimaryColor ;
  }

  static Color getAppbarTitleColor(){
    return Get.find<ThemeController>().darkTheme ? mycolorWhite : lPrimaryColor;
  }

  static Color getButtonTextColor(){
    return Get.find<ThemeController>().darkTheme ? mycolorBlack : mycolorWhite;
  }

  static Color getPrimaryColor(){
    return  myprimaryColor ;
  }

  static Color getAppbarBgColor() {
    return Get.find<ThemeController>().darkTheme ? myappBarColor : mycolorWhite;
  }

  static Color getScreenBgColor(){
    return Get.find<ThemeController>().darkTheme ? mybackgroundColor : lScreenBgColor1;
  }

  static Color getCardBg(){
    return Get.find<ThemeController>().darkTheme ? mycardBgColor : mycolorWhite;
  }
/////revers Card 
 static Color getCardBgRever(){
    return Get.find<ThemeController>().darkTheme ?mycolorWhite :mycardBgColor  ;
  }
  static Color getBottomNavBg(){
    return Get.find<ThemeController>().darkTheme ? mybottomNavBgColor : myprimaryColor;
  }

  static Color getBottomNavIconColor(){
    return Get.find<ThemeController>().darkTheme ? mycolorWhite : mycolorGrey;
  }

  static Color getBottomNavSelectedIconColor(){
    return Get.find<ThemeController>().darkTheme ? myprimaryColor : mycolorWhite;
  }

  static Color getTextFieldTextColor(){
    return Get.find<ThemeController>().darkTheme ? mycolorWhite : lPrimaryColor;
  }

  static Color getTextFieldLabelColor(){
    return Get.find<ThemeController>().darkTheme ? mylabelTextColor : lTextColor;
  }

  static Color getTextColor(){
    return Get.find<ThemeController>().darkTheme ? mycolorWhite : mycolorBlack;
  }

  static Color getTextColor1(){
    return Get.find<ThemeController>().darkTheme ? Colors.white.withOpacity(0.5) : lTextColor;
  }

  static Color getTextFieldBg(){
    return Get.find<ThemeController>().darkTheme ? mytransparentColor : mytransparentColor;
  }

  static Color getTextFieldHintColor(){
    return Get.find<ThemeController>().darkTheme ? myhintTextColor : mycolorGrey;
  }

  static Color getPrimaryTextColor(){
    return Get.find<ThemeController>().darkTheme ? mycolorWhite : mycolorBlack;
  }

  static Color getSecondaryTextColor(){
    return Get.find<ThemeController>().darkTheme ? mycolorWhite.withOpacity(0.8) : mycolorBlack.withOpacity(0.8);
  }

  static Color getDialogBg(){
    return Get.find<ThemeController>().darkTheme ? mycardBgColor : mycolorWhite;
  }

  static Color getStatusColor(){
    return Get.find<ThemeController>().darkTheme ? myprimaryColor : lPrimaryColor;
  }

  static Color getFieldDisableBorderColor(){
    return Get.find<ThemeController>().darkTheme ? myfieldDisableBorderColor : mycolorGrey.withOpacity(0.3);
  }

  static Color getFieldEnableBorderColor(){
    return Get.find<ThemeController>().darkTheme ? myprimaryColor : lPrimaryColor;
  }

  static Color getTextColor2(){
    return Get.find<ThemeController>().darkTheme ? mycolorWhite : mycolorGrey;
  }

  static Color getBottomNavColor(){
    return Get.find<ThemeController>().darkTheme ? mybottomNavBgColor : mycolorWhite;
  }

  static Color getUnselectedIconColor(){
    return Get.find<ThemeController>().darkTheme ? mycolorWhite : mycolorGrey.withOpacity(0.6);
  }

  static Color getSelectedIconColor(){
    return Get.find<ThemeController>().darkTheme ? myprimaryColor : lPrimaryColor;
  }

  static Color getPendingStatueColor(){
    return Get.find<ThemeController>().darkTheme ? Colors.grey : Colors.orange;
  }

  static Color getBorderColor(){
    return Get.find<ThemeController>().darkTheme ? Colors.grey.withOpacity(.3) : Colors.grey.withOpacity(.3);
  }

  static const Color pendingColor = Color(0xFFfcb44f);
  static const Color highPriorityPurpleColor = Color(0xFF7367F0);
  static const Color bgColorLight = Color(0xFFf2f2f2);
  static const Color closeRedColor = Color(0xFFEA5455);
  static const Color greenSuccessColor = greenP;
  static const Color redCancelTextColor = Color(0xFFF93E2C);
  static const Color greenP = Color(0xFF28C76F);

}
