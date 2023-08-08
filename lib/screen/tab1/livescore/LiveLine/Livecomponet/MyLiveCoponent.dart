import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import '../../../../../AipProvider/ThemeProvider.dart';
import '../../../../../utils/Color.dart';
import '../../../../../utils/CustomWidget/Countdown.dart';
import '../../../../../utils/CustomWidget/Dotetext.dart';
import '../../../../../utils/CustomWidget/Externel.dart';
import '../../../../../utils/Style.dart';

class MyLiveMatchCoponent extends StatefulWidget {
  final String type;
  var matchData;
  var remainingSeconds;
  MyLiveMatchCoponent(
      {super.key,
      required this.type,
      required this.matchData,
      required this.remainingSeconds});

  @override
  State<MyLiveMatchCoponent> createState() => _MyLiveMatchCoponentState();
}

class _MyLiveMatchCoponentState extends State<MyLiveMatchCoponent> {
  late Timer timer;
  FlutterTts flutterTts = FlutterTts();
  String? previousText;
  bool isSoundEnabled = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    List<Widget> widgetsTeamScore = [];
    return Container(
        height: screenWidth * 0.3,
        width: screenWidth * 0.9,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: CustomStylesBorder.boderRadius10,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
              width: screenWidth * 0.9,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: CustomColor.cricketPrimary,
                  borderRadius: CustomStylesBorder.boderRadius10,
                  border: border),
              height: 310,
              child: widget.type != "Upcoming"
                  ? Stack(
                      children: [
                        Positioned(
                            top: 0,
                            left: 160,
                            child: Text(
                              "${widget.matchData.matchType}",
                              style: CustomStyles.normalTextStyle2,
                            )),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isSoundEnabled = !isSoundEnabled;
                              });
                            },
                            child: Icon(
                              isSoundEnabled
                                  ? Icons.volume_up
                                  : Icons.volume_off,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      margin: const EdgeInsets.only(
                                          top: 5, left: 10, right: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            CustomStylesBorder.borderRadiusfull,
                                        border: border,
                                        image: DecorationImage(
                                          image: NetworkImage(widget
                                                      .matchData.battingTeam ==
                                                  widget.matchData.teamAId
                                                      .toString()
                                              ? widget.matchData.teamAImg
                                                  .toString()
                                              : widget.matchData.teamBImg
                                                  .toString()),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                                widget.matchData.battingTeam
                                                            .toString() ==
                                                        widget.matchData.teamAId
                                                            .toString()
                                                    ? widget
                                                        .matchData.teamAShort
                                                        .toString()
                                                    : widget
                                                        .matchData.teamBShort
                                                        .toString(),
                                                style: CustomStyles
                                                    .cardBoldDarkTextStyleWhite)),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 84,
                                              child: Text(
                                                  widget.matchData.battingTeam
                                                              .toString() ==
                                                          widget
                                                              .matchData.teamAId
                                                              .toString()
                                                      ? widget
                                                          .matchData.teamAScores
                                                          .toString()
                                                          .split("&")[0]
                                                      : widget
                                                          .matchData.teamBScore
                                                          .toString()
                                                          .split("&")[0]
                                                          .replaceAll('\n', ''),
                                                  style: CustomStyles
                                                      .grayTextStyle),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, left: 5),
                                              child: Text(
                                                  widget.matchData
                                                              .battingTeam ==
                                                          widget
                                                              .matchData.teamAId
                                                      ? widget
                                                          .matchData.teamAOver
                                                          .toString()
                                                      : widget
                                                          .matchData.teamBover
                                                          .toString()
                                                          .split("&")[0],
                                                  style: CustomStyles
                                                      .overmontserratwhite),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              height: 130,
                              width: 20,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("images/Line1.png"),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                widget.matchData.firstCircle
                                            .toString()
                                            .contains("Six") ||
                                        widget.matchData.firstCircle
                                            .toString()
                                            .contains("0")
                                    ? Row(
                                        children: widgetsTeamScore,
                                      )
                                    : Container(
                                        width: screenWidth * 0.3,
                                        child: Text(
                                          truncateText(
                                              widget.matchData.firstCircle
                                                  .toString()
                                                  .replaceAll('\n', ''),
                                              15),
                                          style: CustomStyles.firstCircle,
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                              ],
                            )
                          ],
                        ),
                      ],
                    )
                  : Container(
                      width: screenWidth * 0.8,
                      child: Column(
                        children: [
                          Text(
                            widget.matchData.matchType,
                            style: CustomStyles.cardBoldTextStyle,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: CustomStylesBorder.boderRadius10,
                              color: CustomColor.cricketWhite,
                              border: border,
                            ),
                            child: CountdownTimerWidget(
                                totalSeconds: widget.remainingSeconds),
                          )
                        ],
                      ),
                    )),
        ));
  }
}

class FinshMatchInLive extends StatefulWidget {
  final String type;
  var matchData;
  var Data;
  FinshMatchInLive(
      {super.key,
      required this.type,
      required this.matchData,
      required this.Data});

  @override
  State<FinshMatchInLive> createState() => _FinshMatchInLiveState();
}

class _FinshMatchInLiveState extends State<FinshMatchInLive> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    List<Widget> widgetsTeamScore = [];
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Container(
      height: 100,
      width: screenWidth * 0.9,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: border,
        boxShadow: [boxshadow],
        color: themeProvider.isDarkTheme
            ? CustomColor.cricketWhite
            : CustomColor.cricketBlackColor,
        borderRadius: CustomStylesBorder.boderRadius10,
      ),
      child: Stack(children: [
        Positioned(
            top: 0,
            left: 160,
            child: Text(
              "${widget.matchData.matchType}",
              style: CustomStyles.livefont,
            )),

        Positioned(
            top: 35,
            left: 100,
            child: Column(
              children: [
                Container(
                  width: 150,
                  alignment: Alignment.center,
                  child: Text(
                    widget.matchData.firstCircle.toString(),
                    style: CustomStyles.cardBoldDarkroboto,
                    textAlign: TextAlign.center,
                  ),
                ),
                sizeboxSmallh,
              ],
            )),

        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        widget.matchData.teamAShort.toString(),
                        style: CustomStyles.cardBoldDarkDrawerTextStyle,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ScoresBox(widget.Data[0].toString(), "A"),
                      Text(
                        "Over/${widget.Data[2].toString()} ",
                        style: CustomStyles.cardBoldDarkTextStyle2,
                      )
                    ],
                  )
                ],
              ),
              //col3

              //col3
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        widget.matchData.teamBShort.toString(),
                        style: CustomStyles.cardBoldDarkDrawerTextStyle,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ScoresBox(widget.Data[1].toString(), "B"),
                      Text(
                        "Over/${widget.Data[3].toString()}",
                        style: CustomStyles.cardBoldDarkTextStyle2,
                      )
                    ],
                  )
                ],
              ),
            ]),

        ///////////////////over
      ]),
    );
  }
}
