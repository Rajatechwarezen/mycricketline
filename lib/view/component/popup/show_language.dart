
import 'package:flutter/material.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';

import '../dailog/language_dailog.dart';

void showLanguageDialog(
    String languageList, Locale selectedLocal, BuildContext context,
    {bool fromSplash = false}) {
  try {
    var language ;

    List  langList = [];




    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: MyColor.getScreenBgColor(),
            content: LanguageDialogBody(
              langList: langList,
              fromSplashScreen: fromSplash,
            ),
          );
        });
  } catch (e) {
    print('Error decoding JSON: $e');
 
  }
}
