import 'package:flutter/material.dart';
import 'package:mycricketline/model/FinishData.dart';
import 'package:provider/provider.dart';

import '../../../AipProvider/FinishApi.dart';
import '../../../AipProvider/ThemeProvider.dart';
import '../../../utils/Color.dart';
import '../../../utils/CustomWidget/Dotetext.dart';
import '../../../utils/CustomWidget/shimmer.dart';
import '../../../utils/Style.dart';
import '../livescore/LiveCustom.dart';
import '../livescore/LiveLine/OnlineLivTape.dart';

class TrendingByfinish extends StatefulWidget {
  var matchid;
  TrendingByfinish({super.key, required this.matchid});

  @override
  State<TrendingByfinish> createState() => _TrendingByfinishState();
}

class _TrendingByfinishState extends State<TrendingByfinish>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    final screenWidth = MediaQuery.of(context).size.width;

    final matchesBySeriesFinish1 = Provider.of<FinishMatchesProvider>(context);

    matchesBySeriesFinish1.trendingMatchesBySeriesFinishData(widget.matchid);
    final matches = matchesBySeriesFinish1.matchesBySeriesFinish;

    if (matches.isEmpty) {
      return summer2;
    } else {
      return SafeArea(
        child: Scaffold(
          body: ListView(
            children: matches.map((match) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OnlinelineLiveTabTab(
                              idMatch: match.matchId,
                              type: "Finish",
                              data: [
                                match.teamAScore,
                                match.teamBScore,
                                match.teamAOver?.split("&")[0],
                                match.teamBOver?.split("&")[0]
                              ],
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
                              '•Finish',
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
                                      truncateText(match.series.toString(), 35),
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w600),
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
                                    teamAImg: match.teamAImg,
                                    teamBImg: match.teamBImg,
                                    teamName: match.teamAShort,
                                    teamName2: match.teamBShort,
                                    teamScore: match.teamAScores,
                                    teamScore2: match.teamBScores,
                                    teamOver: match.teamAOver,
                                    teamType: match.matchType,
                                    matchTime: match.matchTime,
                                    teamOver2: match.teamBOver),
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

                      sizeboxSmallh,
                      Row(
                        children: [
                          Row(
                            children: [
                              sizeboxSmallw,
                              //Aw -
                              Text(match.result.toString(),
                                  style: CustomStyles.cardTextStyle2),
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
