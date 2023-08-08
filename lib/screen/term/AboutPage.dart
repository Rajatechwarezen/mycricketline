import 'package:flutter/material.dart';
import 'package:mycricketline/utils/CustomWidget/shimmer.dart';

import '../../AipProvider/trem&con/termandcon.dart';
import '../../utils/Color.dart';
import '../../utils/Style.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: about(),
      builder: (context, snapshot) {
        print(snapshot.data);
        return snapshot.hasData
            ? Scaffold(
                appBar: AppBar(
                    iconTheme:
                        IconThemeData(color: CustomColor.cricketBlackColor),
                    elevation: 0,
                    backgroundColor: CustomColor.cricketAppBackground,
                    title: Center(
                        child: Text(
                      "About",
                      style: CustomStyles.cardBoldDarkDrawerTextStyle,
                    ))),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    snapshot.data!.map((e) => e.ppolicy).toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              )
            : summer;
      },
    );
  }
}
