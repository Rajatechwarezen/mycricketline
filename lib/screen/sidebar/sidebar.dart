import 'package:flutter/material.dart';
import 'package:mycricketline/screen/term/AboutPage.dart';
import 'package:mycricketline/screen/term/PrivacyPolicyPage.dart';
import 'package:mycricketline/screen/term/TermsandConditionsPage.dart';
import 'package:mycricketline/utils/Color.dart';
import 'package:mycricketline/utils/Style.dart';
import 'package:provider/provider.dart';

import '../../AipProvider/ThemeProvider.dart';

class CustomNavigationDrawer extends StatefulWidget {
  var isDrawerOpen;

  CustomNavigationDrawer({super.key, required this.isDrawerOpen});

  @override
  _CustomNavigationDrawerState createState() => _CustomNavigationDrawerState();
}

class _CustomNavigationDrawerState extends State<CustomNavigationDrawer>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Stack(
      children: [
        // Main Content

        // Drawer
        AnimatedContainer(
          color: CustomColor.cricketAppBackground,
          duration: const Duration(milliseconds: 500),
          transform: Matrix4.translationValues(
            0.0,
            widget.isDrawerOpen ? 0.0 : MediaQuery.of(context).size.height,
            0.0,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height,
            color: themeProvider.isDarkTheme
                ? CustomColor.cricketWhite
                : CustomColor.cricketBlackColor,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
//Social Visit
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Social Visit ",
                        style: CustomStyles.cardBoldDarkTextStyle,
                      ),
                    ),
                    Container(
                      height: 150,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      color: CustomColor.cricketAppBackground,
                      child: Column(children: [
                        customSliderbar(context, "Facebook",
                            TermsAndConditionsPage(), Icons.facebook),
                        customSliderbar(
                            context, "Istagram", AboutPage(), Icons.abc),
                      ]),
                    ),
                  ],
                ),

                // visit
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Visit ",
                        style: CustomStyles.cardBoldDarkTextStyle,
                      ),
                    ),
                    Container(
                      height: 250,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      color: CustomColor.cricketAppBackground,
                      child: Column(
                        children: [
                          customSliderbar(context, "Rate Us",
                              TermsAndConditionsPage(), Icons.star),
                          customSliderbar(context, "Check For Update",
                              AboutPage(), Icons.update),
                          customSliderbar(context, "Invite Frieds ",
                              TermsAndConditionsPage(), Icons.share)
                        ],
                      ),
                    ),
                  ],
                ),

                // Trem and condition
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Abouts Us ",
                        style: CustomStyles.cardBoldDarkTextStyle,
                      ),
                    ),
                    Container(
                      height: 250,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      color: CustomColor.cricketAppBackground,
                      child: Column(
                        children: [
                          customSliderbar(context, "Terms and Conditions",
                              TermsAndConditionsPage(), Icons.stream),
                          customSliderbar(context, "About Us", AboutPage(),
                              Icons.read_more),
                          customSliderbar(
                              context,
                              "Privacy Policy",
                              TermsAndConditionsPage(),
                              Icons.private_connectivity)
                        ],
                      ),
                    ),
                  ],
                ),

                //Social Visit
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Setting",
                        style: CustomStyles.cardBoldDarkTextStyle,
                      ),
                    ),
                    Container(
                      height: 80,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      color: CustomColor.cricketAppBackground,
                      child: Column(children: [
                        customSliderbar(context, "Dark Mode",
                            TermsAndConditionsPage(), Icons.dark_mode),
                      ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

customSliderbar(context, name, routes, icons) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => routes));
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 40,
            width: 100,
            margin: const EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              borderRadius: CustomStylesBorder.boderRadius10,
            ),
            child: Icon(icons),
          ),
        ),
        Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: CustomStyles.cardBoldTextStyle2),
                const SizedBox(
                  height: 5,
                ),
              ],
            )),
        Expanded(
          flex: 1,
          child: Container(
            height: 70,
            width: 100,
            margin: const EdgeInsets.only(left: 10),
            child: InkWell(
                onTap: () {}, child: const Icon(Icons.arrow_forward_ios)),
          ),
        ),
      ],
    ),
  );
}
