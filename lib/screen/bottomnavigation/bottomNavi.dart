import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mycricketline/screen/tab1/trending/trending.dart';
import 'package:mycricketline/utils/Color.dart';
import 'package:mycricketline/utils/Style.dart';
// import 'package:rive/rive.dart';

import '../../utils/bottomcontroller.dart';
import '../Myhome.dart';
import '../short/shortReel.dart';
import '../tab1/livescore/Pip/pip.dart';
import '../tab1/trending/fullListTrending.dart';

class BottomNavi extends StatefulWidget {
  BottomNavi({Key? key}) : super(key: key);

  @override
  State<BottomNavi> createState() => _BottomNaviState();
}

class _BottomNaviState extends State<BottomNavi> {
  var Maincenter = MainAxisAlignment.spaceAround;
  @override
  Widget build(BuildContext context) {
    // SMITrigger? searchTrigger;
    final screenWidth = MediaQuery.of(context).size.width;
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                color: Cricket_white,
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
                        MaterialPageRoute(builder: (context) => CricketPage()),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: Maincenter,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: CustomStylesBorder.borderRadiusfull,
                            image: const DecorationImage(
                              image: AssetImage("images/home.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Text(
                          "Home",
                          style: CustomStyles.cardBoldTextStyle2,
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FullTrending()),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: Maincenter,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          margin: const EdgeInsets.only(left: 10),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/match.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Text(
                          "Match",
                          style: CustomStyles.cardBoldTextStyle2,
                        )
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
                      mainAxisAlignment: Maincenter,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: CustomStylesBorder.borderRadiusfull,
                            image: const DecorationImage(
                              image: AssetImage("images/short.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Text(
                          "Short",
                          style: CustomStyles.cardBoldTextStyle2,
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle "More" navigation
                    },
                    child: Column(
                      mainAxisAlignment: Maincenter,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: CustomStylesBorder.borderRadiusfull,
                            image: const DecorationImage(
                              image: AssetImage("images/dot.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Text(
                          "More",
                          style: CustomStyles.cardBoldTextStyle2,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
