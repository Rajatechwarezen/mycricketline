import 'package:flutter/material.dart';
import 'package:mycricketline/AipProvider/upcomingapi.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                  iconTheme: const IconThemeData(color: Colors.black),
                  elevation: 0,
                  backgroundColor: Cricket_app_Background,
                  title: Center(
                      child: Text(
                    "Upcoming",
                    style: CustomStyles.cardBoldDarkDrawerTextStyle,
                  )))
              : null,
          body: ListView(
            children: matches.map((match) {
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
                              data: const ["---", "---", "---", "---"],
                            )),
                  );
                },
                child: Container(
                  width: screenWidth * 2,
                  height: 220,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                            Text(
                              '•Upcoming',
                              style: CustomStyles.livefont,
                            ),
                            sizeboxSmallw,
                            Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      truncateText(match.series.toString(), 30),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 9),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                          "${match.matchTime.toString()} : ${match.matchDate.toString()}"),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                      const Divider(
                        color: Cricket_textColorSecondary,
                        thickness: 1,
                      ),
                      // Row of team 1
                      Row(
                        children: [
                          sizeboxSmallw,
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                teamheadingscore2(
                                    teamAImg: match.teamAImage,
                                    teamBImg: match.teamBImage,
                                    teamName: match.teamAShort,
                                    teamName2: match.teamBShort,
                                    teamScore: "-",
                                    teamScore2: "-",
                                    teamOver: '-',
                                    teamType: match.matchType,
                                    matchTime: match.matchTime,
                                    teamOver2: "-"),
                              ],
                            ),
                          ),
                          sizeboxSmallw,
                        ],
                      ),
                      const Divider(
                        color: Cricket_textColorSecondary,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              sizeboxSmallw,
                              //Aw -

                              const Text("Match Timing Left"),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Cricket_Gradient_color1,
                                      borderRadius:
                                          CustomStylesBorder.boderRadius10,
                                      border: border,
                                    ),
                                    child: Center(
                                      child: CountdownTimerWidget(
                                          totalSeconds: remainingSeconds),
                                    ),
                                  )),
                            ],
                          ),
                        ],
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
