import 'package:flutter/material.dart';

import '../../AipProvider/trem&con/termandcon.dart';
import '../../utils/Color.dart';
import '../../utils/CustomWidget/shimmer.dart';
import '../../utils/Style.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ppolicyget(),
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
                      "Privacy Policy",
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
