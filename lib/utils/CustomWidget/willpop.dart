import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycricketline/utils/Color.dart';
import 'package:provider/provider.dart';

import '../../AipProvider/ThemeProvider.dart';

class WillPopWidget extends StatelessWidget {
  final Widget child;
  final String nextRoute;

  const WillPopWidget({Key? key, required this.child, this.nextRoute = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (nextRoute.isEmpty) {
          return showExitDialog(context);
        } else {
          Navigator.of(context).pushNamed(nextRoute);
          return false;
        }
      },
      child: child,
    );
  }
}

showExitDialog(BuildContext context) async {
  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: CustomColor.cricketPrimary,
        contentTextStyle: TextStyle(
          color: themeProvider.isDarkTheme
              ? CustomColor.cricketWhite
              : CustomColor.cricketBlackColor,
          fontFamily: 'Lora',
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
        content: Text(
          "Are you sure you want to exit?",
          style: TextStyle(
              color: themeProvider.isDarkTheme
                  ? CustomColor.cricketWhite
                  : CustomColor.cricketBlackColor,
              fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              "No",
              style: TextStyle(
                  color: themeProvider.isDarkTheme
                      ? CustomColor.cricketWhite
                      : CustomColor.cricketBlackColor),
            ),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: Text(
              "Yes",
              style: TextStyle(color: CustomColor.cricketWhite),
            ),
          ),
        ],
      );
    },
  );
}
