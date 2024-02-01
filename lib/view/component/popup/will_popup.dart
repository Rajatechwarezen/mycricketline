

import 'package:sprotbuzz/core/utilis/AllColor.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';


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

  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: myColorRed,
        contentTextStyle: TextStyle(
          color:
              MyColor.bgColorLight
              ,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
        content: Text(
          "Are you sure you want to exit?",
          style: TextStyle(
              color:  MyColor.bgColorLight,
              fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              "No",
              style: TextStyle(
                  color:  MyColor.bgColorLight),
            ),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: Text(
              "Yes",
              style: TextStyle(color: MyColor.bgColorLight),
            ),
          ),
        ],
      );
    },
  );
}
