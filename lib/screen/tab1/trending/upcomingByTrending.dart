import 'package:flutter/material.dart';
import 'package:mycricketline/AipProvider/upcomingapi.dart';
import 'package:provider/provider.dart';

import '../../../AipProvider/ThemeProvider.dart';
import '../../../utils/Color.dart';
import '../../../utils/CustomWidget/Countdown.dart';
import '../../../utils/CustomWidget/Dotetext.dart';
import '../../../utils/CustomWidget/shimmer.dart';
import '../../../utils/Style.dart';
import '../livescore/LiveCustom.dart';
import '../livescore/LiveLine/OnlineLivTape.dart';

class TrendingByupcoming extends StatefulWidget {
  var matchid;
  TrendingByupcoming({super.key, required this.matchid});

  @override
  State<TrendingByupcoming> createState() => _TrendingByupcomingState();
}

class _TrendingByupcomingState extends State<TrendingByupcoming> {
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    final screenWidth = MediaQuery.of(context).size.width;

    final trendingUpcoming1 = Provider.of<UpcomingMatchesProvider>(context);

    trendingUpcoming1.trendingUpcomingMatchesFullData(widget.matchid);
    final matches = trendingUpcoming1.trendingUpcoming;

    if (matches.isEmpty) {
      return summer2;
    } else {
      return SafeArea(
        child: Scaffold(
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
                      Divider(
                        color: CustomColor.cricketTextColorSecondary,
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
                                    width: 100,
                                    decoration: BoxDecoration(
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
