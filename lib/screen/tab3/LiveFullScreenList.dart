import 'package:flutter/material.dart';
import 'package:mycricketline/screen/tab1/livescore/LiveLine/RealTimeLive.dart';
import 'package:provider/provider.dart';

import '../../AipProvider/LiveMatch.dart';
import '../../utils/Color.dart';
import '../../utils/CustomWidget/Dotetext.dart';
import '../../utils/CustomWidget/shimmer.dart';
import '../../utils/Style.dart';
import '../tab1/livescore/LiveCustom.dart';
import '../tab1/livescore/LiveLine/OnlineLivTape.dart';

class LiveFullDemo extends StatefulWidget {
  var lengthType;
  LiveFullDemo({super.key, this.lengthType});

  @override
  State<LiveFullDemo> createState() => _LiveFullDemoState();
}

class _LiveFullDemoState extends State<LiveFullDemo> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final liveMatchProvider = Provider.of<LiveMatchProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: widget.lengthType.toString().contains("Full")
            ? AppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                elevation: 0,
                backgroundColor: Cricket_app_Background,
                title: Center(
                    child: Text(
                  "Live List",
                  style: CustomStyles.cardBoldDarkDrawerTextStyle,
                )))
            : null,
        body: FutureBuilder<void>(
          future: liveMatchProvider.fetchLiveMatches(),
          builder: (context, snapshot) {
            final matches = liveMatchProvider.liveMatches;

            if (matches.isEmpty) {
              return summer2;
            } else {
              return SafeArea(
                child: Scaffold(
                  body: ListView(
                    children: matches.map((match) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OnlinelineLiveTabTab(
                                      idMatch: match.matchId,
                                      type: match.matchStatus,
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
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
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
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              match.series,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 9),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(
                                                  "${match.matchTime} : ${match.matchDate}"),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        teamheadingscore2(
                                            teamAImg: match.teamAImg,
                                            teamBImg: match.teamBImg,
                                            teamName: match.teamAShort,
                                            teamName2: match.teamBShort,
                                            teamScore: match.teamAScore,
                                            teamScore2: match.teamBScore,
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

                              Row(
                                children: [
                                  Row(
                                    children: [
                                      sizeboxSmallw,
                                      //Aw -
                                      Text(match.favTeam.toString()),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Container(
                                            height: 35,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              color: Cricket_Gradient_color1,
                                              borderRadius: CustomStylesBorder
                                                  .boderRadius10,
                                              border: border,
                                            ),
                                            child: Center(
                                              child: Text(
                                                match.min.toString(),
                                                style: CustomStyles
                                                    .smallLightTextStylebold,
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 10),
                                      child: Container(
                                        height: 35,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: Cricket_Gradient_color2,
                                          borderRadius:
                                              CustomStylesBorder.boderRadius10,
                                          border: border,
                                        ),
                                        child: Center(
                                          child: Text(
                                            match.max.toString(),
                                            style: CustomStyles
                                                .smallLightTextStylebold,
                                          ),
                                        ),
                                      )),
                                ],
                              ),

                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10),
                                    child: Text(
                                      truncateText(match.venue, 60),
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
              );
            }
          },
        ),
      ),
    );
  }
}
