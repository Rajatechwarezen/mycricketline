import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycricketline/utils/Color.dart';

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
        backgroundColor: Cricket_Primary,
        contentTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Lora',
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
        content: const Text(
          "Are you sure you want to exit?",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              "No",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: Text(
              "Yes",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}
