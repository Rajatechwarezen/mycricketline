import 'package:flutter/material.dart';
import 'package:mycricketline/AipProvider/upcomingapi.dart';
import 'package:provider/provider.dart';

import '../../AipProvider/ThemeProvider.dart';
import '../../model/upcomingData.dart';
import '../../utils/Color.dart';
import '../../utils/CustomWidget/Countdown.dart';
import '../../utils/CustomWidget/Dotetext.dart';
import '../../utils/CustomWidget/shimmer.dart';
import '../../utils/Style.dart';
import '../tab1/livescore/LiveCustom.dart';
import '../tab1/livescore/LiveLine/OnlineLivTape.dart';
import '../tab1/livescore/LiveLine/RealTimeLive.dart';

class Upcomings extends StatefulWidget {
  var lengthType;

  Upcomings({super.key, required this.lengthType});

  @override
  State<Upcomings> createState() => _UpcomingsState();
}

class _UpcomingsState extends State<Upcomings> {
  int _currentIndex = 0;
  final int _batchSize = 5;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    final upcommingMatchProvider =
        Provider.of<UpcomingMatchesProvider>(context);

    upcommingMatchProvider.fetchUpcomingMatchesFullData();
    final matches = upcommingMatchProvider.upcomingMatches;

    if (matches.isEmpty) {
      return summer2;
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: widget.lengthType.toString().contains("Full")
              ? AppBar(
                  iconTheme:
                      IconThemeData(color: CustomColor.cricketBlackColor),
                  elevation: 0,
                  backgroundColor: CustomColor.cricketAppBackground,
                  title: Center(
                      child: Text(
                    "Upcoming",
                    style: CustomStyles.cardBoldDarkDrawerTextStyle,
                  )))
              : null,
          body: ListView(
            children: matches.asMap().entries.map((match1) {
              int index = match1.key;
              Upcomingdata match = match1.value;
              final matchDateTime = parseMatchDateTime(
                  match.matchDate.toString(), match.matchTime.toString());
              final remainingSeconds = calculateRemainingSeconds(matchDateTime);

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OnlinelineLiveTabTab(
                              idMatch: match.matchId,
                              type: "Upcoming",
                              data: const ["", "", "", ""],
                            )),
                  );
                },
                child: Container(
                  width: screenWidth * 2,
                  height: 220,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkTheme
                        ? CustomColor.cricketWhite
                        : CustomColor.cricketBlackColor,
                    border: border,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [boxshadow],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Row(
                          children: [
                            sizeboxSmallw,
                            Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Upcoming',
                                      style: CustomStyles.livefont,
                                    ),
                                    Text(
                                      truncateText(match.series.toString(), 30),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 9),
                                    ),
                                  ],
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                  "${match.matchTime.toString()} : ${match.matchDate.toString()}"),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: CustomColor.cricketTextColorSecondary,
                        thickness: 1,
                      ),
                      // Row of team 1
                      Row(
                        children: [
                          sizeboxSmallw,
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                height: 30,
                                                width: 30,
                                                margin: const EdgeInsets.only(
                                                    left: 5, right: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      CustomStylesBorder
                                                          .borderRadiusfull,
                                                  image: DecorationImage(
                                                    image: NetworkImage(match
                                                        .teamAImage
                                                        .toString()),
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(match.teamA.toString(),
                                                    style: CustomStyles
                                                        .cardBoldTextStyle2),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                height: 30,
                                                width: 30,
                                                margin: const EdgeInsets.only(
                                                    left: 5, right: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      CustomStylesBorder
                                                          .borderRadiusfull,
                                                  image: DecorationImage(
                                                    image: NetworkImage(match
                                                        .teamBImage
                                                        .toString()),
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(match.teamB.toString(),
                                                    style: CustomStyles
                                                        .cardBoldTextStyle2),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          sizeboxSmallw,
                        ],
                      ),
                      Divider(
                        color: CustomColor.cricketTextColorSecondary,
                        thickness: 1,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Aw -

                            const Text("Match Timing Left"),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: CustomStylesBorder.boderRadius10,
                                border: border,
                              ),
                              child: Center(
                                child: CountdownTimerWidget(
                                    totalSeconds: remainingSeconds),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Divider(
                        color: CustomColor.cricketTextColorSecondary,
                        thickness: 1,
                      ),

                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              truncateText(match.venue.toString(), 60),
                              style: CustomStyles.smallLightTextStylebold2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }
  }
}
