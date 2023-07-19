import 'package:flutter/material.dart';
import 'package:mycricketline/model/FinishData.dart';
import 'package:provider/provider.dart';

import '../../AipProvider/FinishApi.dart';
import '../../utils/Color.dart';
import '../../utils/CustomWidget/Dotetext.dart';
import '../../utils/CustomWidget/shimmer.dart';
import '../../utils/Style.dart';
import '../tab1/livescore/LiveCustom.dart';
import '../tab1/livescore/LiveLine/OnlineLivTape.dart';

// ignore: must_be_immutable
class FinishMatch extends StatefulWidget {
  var lengthType;
  FinishMatch({super.key, required lengthType});

  @override
  State<FinishMatch> createState() => _FinishMatchState();
}

class _FinishMatchState extends State<FinishMatch> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final upcommingMatchProvider = Provider.of<FinishMatchesProvider>(context);

    upcommingMatchProvider.fetchUpcomingMatchesFullData();
    final matches = upcommingMatchProvider.finishDataMatches;

    if (matches.isEmpty) {
      return summer2;
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: widget.lengthType.toString().contains("Full")
              ? AppBar(title: Text("Finish"))
              : null,
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
                                match.teamAOver.split("&")[0],
                                match.teamBOver.split("&")[0]
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
                    color: Cricket_white,
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
                                      truncateText(match.series, 35),
                                      maxLines: 1,
                                      style: TextStyle(
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

                      const Divider(
                        color: Cricket_textColorSecondary,
                        thickness: 1,
                      ),

                      sizeboxSmallh,
                      Row(
                        children: [
                          Row(
                            children: [
                              sizeboxSmallw,
                              //Aw -
                              Text(match.result,
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
