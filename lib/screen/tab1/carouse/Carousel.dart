import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mycricketline/utils/CustomWidget/Externel.dart';
import 'package:provider/provider.dart';

import '../../../AipProvider/LiveMatch.dart';
import '../../../model/Allmodel.dart';
import '../../../utils/Color.dart';
import '../../../utils/CustomWidget/Countdown.dart';
import '../../../utils/CustomWidget/TitleBtn.dart';
import '../../../utils/CustomWidget/shimmer.dart';
import '../../../utils/Style.dart';
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
                      // Add the pagination option
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
                          return Cricket_Gradient_color1;
                        } else if (detail.matchStatus == "Finished") {
                          return Cricket_Gradient_color2;
                        } else {
                          return Cricket_BlackColor3;
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
                          return ["---", "---", "---", "---"];
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
                              height: screenWidth * 0.5,
                              decoration: BoxDecoration(
                                borderRadius: CustomStylesBorder.boderRadius10,
                                border: border,
                                boxShadow: [boxshadow],
                                color: Colors.white, // kiya color
                              ),
                              margin: const EdgeInsets.only(
                                  top: 5, left: 10, right: 10),
                              padding: const EdgeInsets.all(10),
                              child: Stack(children: [
                                Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          margin: const EdgeInsets.only(
                                              top: 5, left: 10, right: 10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: CustomStylesBorder
                                                .borderRadiusfull,
                                            border: border,
                                            image: DecorationImage(
                                              image:
                                                  NetworkImage(detail.teamAImg),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          margin: const EdgeInsets.only(
                                              top: 5, left: 10, right: 10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: CustomStylesBorder
                                                .borderRadiusfull,
                                            border: border,
                                            image: DecorationImage(
                                              image:
                                                  NetworkImage(detail.teamBImg),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                // Positioned(
                                //   top: 10,
                                //   right: 124,
                                //   child: Center(
                                //     child: Container(
                                //       height: screenWidth * 0.2,
                                //       width: screenWidth * 0.2,
                                //       margin: const EdgeInsets.only(
                                //           top: 5, left: 10, right: 10),
                                //       padding: const EdgeInsets.all(10),
                                //       decoration: const BoxDecoration(
                                //         image: DecorationImage(
                                //           image: AssetImage("images/vs2.png"),
                                //           fit: BoxFit.fill,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Positioned(
                                  top: 40,
                                  left: 190,
                                  child: detail.matchStatus == "Upcoming"
                                      ? Container(
                                          decoration: BoxDecoration(
                                              color: Cricket_Gradient_color1,
                                              borderRadius: CustomStylesBorder
                                                  .boderRadius10),
                                          child: CountdownTimerWidget(
                                              totalSeconds: remainingSeconds),
                                        )
                                      : const Text(""),
                                ),

                                Positioned(
                                    top: 10,
                                    left: 70,
                                    child: Container(
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(children: [
                                            Text(
                                              detail.teamAShort,
                                              style: CustomStyles
                                                  .cardBoldDarkDrawerTextStyle,
                                            ),
                                            Text(
                                              checkChange()[0],
                                              style:
                                                  CustomStyles.cardTextStyle2,
                                            ),
                                          ]),
                                          Column(children: [
                                            Text(
                                              detail.teamBShort,
                                              style: CustomStyles
                                                  .cardBoldDarkDrawerTextStyle,
                                            ),
                                            Text(
                                              checkChange()[1],
                                              style:
                                                  CustomStyles.cardTextStyle2,
                                            ),
                                          ]),
                                        ],
                                      ),
                                    )),

                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: Container(
                                    width: screenWidth * 0.9,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          CustomStylesBorder.boderRadius10,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(children: [
                                            Text(
                                              detail.matchStatus,
                                              style: CustomStyles
                                                  .smallLightTextStylebold,
                                            ),
                                            Text(
                                              detail.series,
                                              overflow: TextOverflow.ellipsis,
                                              style: CustomStyles
                                                  .smallLightTextStyle,
                                            )
                                          ]),
                                          Row(children: [
                                            Text(
                                              "",
                                              style: CustomStyles
                                                  .smallLightTextStylebold,
                                            ),
                                            Text(
                                              ' :- ${detail.matchType}',
                                              style: CustomStyles
                                                  .smallLightTextStyle,
                                            )
                                          ]),
                                        ]),
                                  ),
                                ),
                                Positioned(
                                    top: 0,
                                    right: 10,
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: screenWidth * 0.3,
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: colorChange(),
                                            borderRadius: CustomStylesBorder
                                                .boderRadius10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.play_arrow,
                                              size: 10,
                                              color: Cricket_white,
                                            ),
                                            Text(
                                              detail.matchStatus,
                                              style: CustomStyles.cardTextStyle,
                                            ),
                                          ],
                                        ))),
                              ]),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 150,
                    child: Container(
                      width: 350,
                      height: 170,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: border,
                        borderRadius: CustomStylesBorder.boderRadius10,
                        image: const DecorationImage(
                          image: AssetImage("images/vs.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(
                      home.length, // Replace `totalSlides` with the total number of slides
                      (index) {
                        return Container(
                          width: 5,
                          height: 5,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentSlide == index
                                  ? Cricket_Primary
                                  : Colors.white,
                              border: border),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
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
      color: Colors.black.withOpacity(0.5),
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
