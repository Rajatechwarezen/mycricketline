import 'package:flutter/material.dart';
import 'package:mycricketline/utils/CustomWidget/shimmer.dart';
import 'package:provider/provider.dart';

import '../../../../AipProvider/LiveMatch.dart';
import '../../../../AipProvider/ThemeProvider.dart';
import '../../../../utils/Color.dart';
import '../../../../utils/CustomWidget/Dotetext.dart';
import '../../../../utils/CustomWidget/TitleBtn.dart';
import '../../../../utils/Style.dart';

import '../../../tab3/LiveFullScreenList.dart';
import '../LiveCustom.dart';
import 'OnlineLivTape.dart';

class LiveScores extends StatefulWidget {
  const LiveScores({super.key});

  @override
  State<LiveScores> createState() => _LiveScoresState();
}

class _LiveScoresState extends State<LiveScores> {
  @override
  Widget build(BuildContext context) {
    final liveMatchProvider = Provider.of<LiveMatchProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return FutureBuilder<void>(
      future: liveMatchProvider.fetchLiveMatches(),
      builder: (context, snapshot) {
        final matches = liveMatchProvider.liveMatches;

        // ignore: unnecessary_null_comparison
        if (matches.isEmpty) {
          return Text(" ");
        } else {
          return Column(
            children: [
              titlebtn(
                  context1: context,
                  HeadName: 'Live Scores',
                  Headno: matches.length,
                  Routes: LiveFullDemo(
                    lengthType: "Full",
                  )),
              SizedBox(
                height: 150,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: matches.map((match) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OnlinelineLiveTabTab(
                                      idMatch: match.matchId,
                                      type: match.matchStatus,
                                      data: [
                                        match.teamAScore
                                            .toString()
                                            .split("&")[0],
                                        match.teamBScore
                                            .toString()
                                            .split("&")[0],
                                        match.teamAOver.split("&")[0],
                                        match.teamBOver.split("&")[0]
                                      ],
                                    )),
                          );
                        },
                        child: Container(
                          width: 300,
                          height: 120,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
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
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      '•${match.matchStatus}',
                                      style: CustomStyles.livefont,
                                    ),
                                    sizeboxSmallw,
                                    Text(truncateText(match.series, 32)),
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
                                  Column(
                                    children: [
                                      teamImage2(match.teamAImg),
                                    ],
                                  ),
                                  sizeboxSmallw,
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        teamheadingscore(
                                          teamName: match.teamA,
                                          teamScore: match.teamAScore
                                              .toString()
                                              .split("&")[0],
                                          teamOver:
                                              match.teamAOver.split("&")[0],
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizeboxSmallw,
                                ],
                              ),

                              // Row of team 2
                              sizeboxSmallh,
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      teamImage2(match.teamBImg),
                                    ],
                                  ),
                                  sizeboxSmallw,
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        teamheadingscore(
                                          teamName: match.teamB,
                                          teamScore: match.teamBScore
                                              .toString()
                                              .split("&")[0],
                                          teamOver:
                                              match.teamBOver.split("&")[0],
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizeboxSmallw,
                                ],
                              ),

                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10),
                                    child: Text(
                                      truncateText(match.venue, 50),
                                      style:
                                          CustomStyles.smallLightTextStylebold2,
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
              )
            ],
          );
        }
      },
    );
  }
}
