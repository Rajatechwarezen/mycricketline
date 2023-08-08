import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mycricketline/screen/tab1/trending/trending.dart';
import 'package:mycricketline/utils/Color.dart';
import 'package:mycricketline/utils/Style.dart';
import 'package:provider/provider.dart';
// import 'package:rive/rive.dart';

import '../../AipProvider/ThemeProvider.dart';
import '../../utils/bottomcontroller.dart';
import '../Ads/bannerAds.dart';
import '../Myhome.dart';
import '../short/shortReel.dart';
import '../tab1/trending/fullListTrending.dart';

class BottomNavi extends StatefulWidget {
  final void Function() toggleDrawer;

  BottomNavi({Key? key, required this.toggleDrawer}) : super(key: key);

  @override
  State<BottomNavi> createState() => _BottomNaviState();
}

class _BottomNaviState extends State<BottomNavi> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    // SMITrigger? searchTrigger;
    final screenWidth = MediaQuery.of(context).size.width;
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Column(
        children: [
          // BannerAdWidget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  width: screenWidth * 1,
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkTheme
                        ? CustomColor.cricketWhite
                        : CustomColor.cricketBlackColor,
                    border: border,
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CricketPage()),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [customMenubar("Home", "images/home.png")],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullTrending()),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            customMenubar("Match", "images/match.png"),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            customMenubar("Short", "images/short.png"),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.toggleDrawer,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            customMenubar("More", "images/dot.png"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

customMenubar(name, img) {
  var Maincenter = MainAxisAlignment.center;
  return Column(
    mainAxisAlignment: Maincenter,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        height: 30,
        width: 30,
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: CustomStylesBorder.borderRadiusfull,
          image: DecorationImage(
            alignment: Alignment.centerLeft,
            image: AssetImage(img),
            fit: BoxFit.contain,
          ),
        ),
      ),
      Text(
        name,
        style: CustomStyles.cardBoldTextStyle2,
        textAlign: TextAlign.center,
      )
    ],
  );
}
