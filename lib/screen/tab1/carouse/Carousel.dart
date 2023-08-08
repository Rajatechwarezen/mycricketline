import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mycricketline/utils/CustomWidget/Dotetext.dart';
import 'package:mycricketline/utils/CustomWidget/Externel.dart';
import 'package:provider/provider.dart';

import '../../../AipProvider/LiveMatch.dart';
import '../../../AipProvider/ThemeProvider.dart';
import '../../../model/Allmodel.dart';
import '../../../utils/Color.dart';
import '../../../utils/CustomWidget/Countdown.dart';
import '../../../utils/CustomWidget/TitleBtn.dart';
import '../../../utils/CustomWidget/shimmer.dart';
import '../../../utils/Style.dart';
import '../../Ads/bannerAds.dart';
import '../../Ads/custom.dart';
import '../../Ads/netiveAds.dart';
import '../../tab3/LiveFullScreenList.dart';
import '../livescore/LiveLine/OnlineLivTape.dart';
import '../livescore/LiveLine/RealTimeLive.dart';

class CorouselContainer extends StatefulWidget {
  const CorouselContainer({super.key});

  @override
  State<CorouselContainer> createState() => _CorouselContainerState();
}

class _CorouselContainerState extends State<CorouselContainer> {
  final CarouselController _carouselController = CarouselController();

  int _currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final liveMatchProvider = Provider.of<LiveMatchProvider>(context);
    final sericesData = Provider.of<SeriesProvider>(context);

    return FutureBuilder(
      future: liveMatchProvider.homeMatches(),
      builder: (context, snapshot) {
        final home = liveMatchProvider.homeMatche;

        return liveMatchProvider.homeMatche.isEmpty
            ? summer
            : Column(
                children: [
                  CarouselSlider(
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      height: screenWidth * 0.6,
                      initialPage: 1,
                      autoPlay: false,
                      pageSnapping: true,
                      aspectRatio: 8 / 9,
                      pauseAutoPlayInFiniteScroll: true,
                      autoPlayCurve: Curves.bounceOut,
                      enableInfiniteScroll: false,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      viewportFraction: 1.0,
                      disableCenter: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentSlide = index;
                        });
                      },
                      enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    ),
                    items: home.take(10).map((detail) {
                      final matchDateTime = parseMatchDateTime(
                          detail.matchDate, detail.matchTime);
                      final remainingSeconds =
                          calculateRemainingSeconds(matchDateTime);

                      colorChange() {
                        if (detail.matchStatus == "Live") {
                          return CustomColor.cricketGradientColor1;
                        } else if (detail.matchStatus == "Finished") {
                          return CustomColor.cricketGradientColor2;
                        } else {
                          return CustomColor.cricketBlackColor3;
                        }
                      }

                      checkChange() {
                        if (detail.matchStatus == "Live") {
                          return [
                            detail.teamAScore,
                            detail.teamBScore,
                            detail.teamAOver.split("&")[0],
                            detail.teamBOver.split("&")[0]
                          ];
                        } else if (detail.matchStatus == "Finished") {
                          return [
                            detail.teamAScore,
                            detail.teamBScore,
                            detail.teamAOver.split("&")[0],
                            detail.teamBOver.split("&")[0]
                          ];
                        } else {
                          return ["", "", "", ""];
                        }
                      }

                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OnlinelineLiveTabTab(
                                          idMatch: detail.matchId,
                                          type: detail.matchStatus,
                                          data: checkChange(),
                                        )),
                              );
                            },
                            child: Container(
                              height: screenHeight / 3.9,
                              width: screenWidth / 1,
                              decoration: BoxDecoration(
                                borderRadius: CustomStylesBorder.boderRadius10,
                                border: border,
                                boxShadow: [boxshadow],
                                color: themeProvider.isDarkTheme
                                    ? CustomColor.cricketWhite
                                    : CustomColor
                                        .cricketBlackColor, // kiya color
                              ),
                              margin: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              padding: const EdgeInsets.all(2),
                              child: Column(children: [
                                //team status
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //team status
                                    Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius: CustomStylesBorder
                                                .boderRadius10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              truncateText(detail.series, 53),
                                              style: CustomStyles
                                                  .smallLightTextStyle2,
                                            ),
                                            Text(
                                              "${detail.matchDate}, ${detail.matchTime}",
                                              style: CustomStyles
                                                  .smallLightTextStylebold2,
                                            ),
                                          ],
                                        )),

                                    //team type
                                    Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius: CustomStylesBorder
                                                .boderRadius10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: colorChange(),
                                                border: border,
                                                borderRadius: CustomStylesBorder
                                                    .boderRadius10,
                                              ),
                                              child: Text(
                                                detail.matchStatus,
                                                style:
                                                    CustomStyles.cardTextStyle(
                                                        CustomColor
                                                            .cricketWhite),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),

                                Divider(
                                  height: 5,
                                ),
                                //team name
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 50,
                                              margin: const EdgeInsets.only(
                                                  top: 2, left: 5, right: 10),
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius: CustomStylesBorder
                                                    .borderRadiusfull,
                                                border: border,
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      detail.teamAImg),
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    detail.matchStatus ==
                                                            "Upcoming"
                                                        ? detail.teamA ?? ""
                                                        : detail.teamAShort ??
                                                            "", // Use the null-aware operator (??) to handle null values
                                                    style: CustomStyles
                                                        .cardBoldDarkDrawerTextStyle,
                                                  ),
                                                  if (detail.matchStatus !=
                                                      "Upcoming") // Use 'if' to conditionally show the Text widget
                                                    Text(
                                                      checkChange()[0],
                                                      style: CustomStyles
                                                          .cardTextStyle2,
                                                    ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 50,
                                              margin: const EdgeInsets.only(
                                                  top: 5, left: 5, right: 10),
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius: CustomStylesBorder
                                                    .borderRadiusfull,
                                                border: border,
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      detail.teamBImg),
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              child: Column(children: [
                                                Text(
                                                  detail.matchStatus ==
                                                          "Upcoming"
                                                      ? detail.teamB ?? ""
                                                      : detail.teamBShort ?? "",
                                                  style: CustomStyles
                                                      .cardBoldDarkDrawerTextStyle,
                                                ),
                                                if (detail.matchStatus !=
                                                    "Upcoming") // Use 'if' to conditionally show the Text widget
                                                  Text(
                                                    checkChange()[1],
                                                    style: CustomStyles
                                                        .cardTextStyle2,
                                                  ),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                Divider(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 0, left: 5, right: 10),
                                      child: detail.matchStatus == "Upcoming"
                                          ? Container(
                                              child: SimpleCounter(
                                                  totalSeconds:
                                                      remainingSeconds),
                                            )
                                          : const Text(""),
                                    ),
                                    Row(
                                      children: [
                                        Text(detail.favTeam.toString()),
                                        smallboxRed(detail.min.toString()),
                                        smallboxblue(detail.max.toString())
                                      ],
                                    ),
                                  ],
                                )
                              ]),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(
                      home.length, // Replace `totalSlides` with the total number of slides
                      (index) {
                        return Container(
                          width: 8,
                          height: 8,
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentSlide == index
                                  ? CustomColor.cricketPrimary
                                  : CustomColor.cricketWhite,
                              border: border),
                        );
                      },
                    ),
                  ),
                  CustomAdWidget(),
                ],
              );
      },
    );
  }
}

CustomOverLay(text, screenWidth) {
  return Container(
    width: screenWidth,
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      borderRadius: CustomStylesBorder.boderRadius10,
      color: CustomColor.cricketBlackColor.withOpacity(0.5),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text(
          text,
          style: CustomStyles.smallLightTextStylebold,
        ),
      ])
    ]),
  );
}
