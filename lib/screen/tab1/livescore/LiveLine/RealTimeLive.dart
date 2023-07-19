import 'dart:async';
import 'dart:convert';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mycricketline/screen/tab1/livescore/LiveLine/BatBowler.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:riverpod/riverpod.dart';

import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';

import 'package:http/http.dart' as http;

import '../../../../model/Livematch.dart';
import '../../../../utils/Color.dart';
import '../../../../utils/CustomWidget/Dotetext.dart';
import '../../../../utils/CustomWidget/Externel.dart';

import '../../../../utils/CustomWidget/htmlntoText.dart';
import '../../../../utils/CustomWidget/shimmer.dart';
import '../../../../utils/Style.dart';

class LiveMatchData extends ChangeNotifier {
  int? _id;
  List<LiveMatchFull>? _matches;

  int? get id => _id;
  List<LiveMatchFull>? get matches => _matches;

  set id(int? value) {
    if (_id != value) {
      _id = value;
      fetchData();
    }
  }

  Future<void> fetchData() async {
    try {
      if (id != null) {
        const url =
            'http://apicricketchampion.in/webservices/liveMatch/20122cd5366e30f0847774c9d7698d30';

        final request = http.MultipartRequest('POST', Uri.parse(url));
        request.fields['match_id'] = "$id";

        final response = await request.send();

        if (response.statusCode == 200) {
          final responseBody = await response.stream.bytesToString();

          final data = json.decode(responseBody);
          if (data['status'] == true && data['data'] != null) {
            if (data['data'] is List) {
              List<LiveMatchFull> matches = (data['data'] as List)
                  .map((json) => LiveMatchFull.fromJson(json))
                  .toList();

              _matches = matches;
            } else if (data['data'] is Map) {
              LiveMatchFull match = LiveMatchFull.fromJson(data['data']);
              _matches = [match];
            } else {
              throw Exception('Invalid data format: Unexpected data type');
            }
          } else {
            throw Exception('Invalid data format: Missing required fields');
          }
        } else {
          throw Exception('Failed to fetch live match');
        }
      } else {
        throw Exception('Invalid id');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to fetch live match');
    }

    notifyListeners();
  }
}

class RealTimeLive extends StatefulWidget {
  final int idMatch;
  final String type;
  final dynamic Data;

  RealTimeLive({required this.idMatch, required this.type, this.Data});

  @override
  _RealTimeLiveState createState() => _RealTimeLiveState();
}

class _RealTimeLiveState extends State<RealTimeLive> {
  LiveMatchData? liveMatchData;
  late Timer timer;
  FlutterTts flutterTts = FlutterTts();
  String? previousText;
  bool isSoundEnabled = false;
  Future<void> speak(String text) async {
    if (isSoundEnabled && text != previousText) {
      previousText = text;

      // await flutterTts.setLanguage('en-US');
      await flutterTts.setLanguage('hi-IN');
      await flutterTts.setPitch(1.0);
      await flutterTts.setSpeechRate(0.6);
      if (text == '-') {
        await flutterTts.setSpeechRate(0.5);
        await flutterTts.setPitch(0.8);
        await flutterTts.setLanguage('hi-IN');
        await flutterTts.speak("Welcome to mycricketline");
      } else {
        await flutterTts.speak(text);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    liveMatchData = LiveMatchData();
    liveMatchData!.id = widget.idMatch;
    liveMatchData!.fetchData();

    // Set up the timer to fetch data every 2 seconds
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        liveMatchData!.fetchData();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    liveMatchData!.dispose();
    timer.cancel();
  }

  var over;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    List<Widget> widgetsTeamScore = [];

    return Scaffold(
      body: ChangeNotifierProvider<LiveMatchData>.value(
        value: liveMatchData!,
        child: Builder(
          builder: (context) {
            final liveMatches = context.watch<LiveMatchData>().matches;

            if (liveMatches != null) {
              return Scaffold(
                  body: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: liveMatches.map((matchDatas) {
                    speak(matchDatas.firstCircle.toString());
                    previousText = matchDatas.firstCircle;
                    if (matchDatas.firstCircle.toString().contains("Six")) {
                      widgetsTeamScore.add(Text(""));

                      widgetsTeamScore.add(
                        Center(
                          child: Container(
                            width: 50,
                            height: 10,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Cricket_white,
                              borderRadius: CustomStylesBorder.borderRadiusfull,
                              image: const DecorationImage(
                                image: AssetImage("images/six.gif"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    if (matchDatas.firstCircle.toString().contains("0")) {
                      widgetsTeamScore.add(Text(""));
                      widgetsTeamScore.add(
                        Center(
                          child: Container(
                            width: 100,
                            height: 60,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Cricket_white,
                              borderRadius: CustomStylesBorder.borderRadiusfull,
                              image: const DecorationImage(
                                image: AssetImage("images/four.gif"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    return Column(
                      children: [
                        ////////main live
                        matchDatas.result != "" &&
                                matchDatas.matchType != "Upcoming"
                            ? Container(
                                height: 100,
                                width: screenWidth * 0.9,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: border,
                                  boxShadow: [boxshadow],
                                  color: Cricket_white,
                                  borderRadius:
                                      CustomStylesBorder.boderRadius10,
                                ),
                                child: Stack(children: [
                                  Positioned(
                                      top: 0,
                                      left: 160,
                                      child: Text(
                                        "${matchDatas.matchType}",
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
                                              matchDatas.firstCircle.toString(),
                                              style: CustomStyles
                                                  .cardBoldDarkroboto,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          sizeboxSmallh,
                                        ],
                                      )),

                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  matchDatas.teamAShort
                                                      .toString(),
                                                  style: CustomStyles
                                                      .cardBoldDarkDrawerTextStyle,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                ScoresBox(
                                                    widget.Data[0].toString(),
                                                    "A"),
                                                Text(
                                                  "Over/${widget.Data[2].toString()} ",
                                                  style: CustomStyles
                                                      .cardBoldDarkTextStyle2,
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
                                                  matchDatas.teamBShort
                                                      .toString(),
                                                  style: CustomStyles
                                                      .cardBoldDarkDrawerTextStyle,
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                ScoresBox(
                                                    widget.Data[1].toString(),
                                                    "B"),
                                                Text(
                                                  "Over/${widget.Data[3].toString()}",
                                                  style: CustomStyles
                                                      .cardBoldDarkTextStyle2,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ]),

                                  ///////////////////over
                                ]),
                              )
                            : Container(
                                height: 100,
                                width: screenWidth * 0.9,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      CustomStylesBorder.boderRadius10,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Cricket_Primary,
                                      borderRadius:
                                          CustomStylesBorder.boderRadius10,
                                      border: border),
                                  width: screenWidth * 1,
                                  height: 310,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 55,
                                                width: 55,
                                                margin: const EdgeInsets.only(
                                                    top: 5,
                                                    left: 10,
                                                    right: 10),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      CustomStylesBorder
                                                          .boderRadius10,
                                                  border: border,
                                                  image: DecorationImage(
                                                    image: NetworkImage(matchDatas
                                                                .battingTeam ==
                                                            matchDatas.teamAId
                                                                .toString()
                                                        ? matchDatas.teamAImg
                                                            .toString()
                                                        : matchDatas.teamBImg
                                                            .toString()),
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      child: Text(
                                                          matchDatas.battingTeam ==
                                                                  matchDatas
                                                                      .teamAId
                                                                      .toString()
                                                              ? matchDatas
                                                                  .teamAShort
                                                                  .toString()
                                                              : matchDatas
                                                                  .teamBShort
                                                                  .toString(),
                                                          style: CustomStyles
                                                              .teamtserratwhite)),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                          matchDatas.battingTeam ==
                                                                  matchDatas
                                                                      .teamAId
                                                                      .toString()
                                                              ? widget.Data[0]
                                                                  .toString()
                                                              : widget.Data[1]
                                                                  .toString(),
                                                          style: CustomStyles
                                                              .grayTextStyle),
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            bottom: 10,
                                                            left: 10),
                                                        child: Text(
                                                            matchDatas.battingTeam ==
                                                                    matchDatas
                                                                        .teamAId
                                                                        .toString()
                                                                ? matchDatas
                                                                    .teamAOver
                                                                    .toString()
                                                                    .split(
                                                                        "&")[0]
                                                                : matchDatas
                                                                    .teamBover
                                                                    .toString()
                                                                    .split(
                                                                        "&")[1],
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
                                          )
                                        ],
                                      ),
                                      Container(
                                        height: 55,
                                        width: 55,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                AssetImage("images/Line1.png"),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(5),
                                              color: Cricket_color1,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                              width: screenWidth * 0.1,
                                              child: Text(
                                                truncateText(
                                                    matchDatas.firstCircle, 6),
                                                style:
                                                    CustomStyles.cardTextStyle,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  isSoundEnabled =
                                                      !isSoundEnabled;
                                                });
                                              },
                                              child: Icon(
                                                isSoundEnabled
                                                    ? Icons.volume_up
                                                    : Icons.volume_off,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                        // Column(
                        //   children: widgetsTeamScore.isNotEmpty
                        //       ? widgetsTeamScore
                        //       : [Container(child: const Text(""))],
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      CustomStylesBorder.boderRadius10,
                                  border: border),
                              width: screenWidth * 0.9,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Text(
                                      "Over :",
                                      style: CustomStyles.cardBoldTextStyle2,
                                    ),
                                    matchDatas.last36Ball != null
                                        ? Row(
                                            children: List.generate(
                                                matchDatas.last4Overs!.last.ball
                                                    .length, (index) {
                                            // print(matchDatas.last4Overs!.map(
                                            //     (e) => e.ball.last.length));

                                            // over =
                                            //     matchDatas.last36Ball![index];
                                            var qover =
                                                matchDatas.last4Overs!.last;
                                            var myoverball = qover.ball[index];
                                            return Row(children: [
                                              Container(
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(5),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      CustomStylesBorder
                                                          .boderRadius10,
                                                  border: border,
                                                ),
                                                width: 30,
                                                height: 25,
                                                child: Text(
                                                  myoverball.toString() ?? '0',
                                                  style: CustomStyles
                                                      .cardTextStyle2,
                                                ),
                                              )
                                            ]);
                                          }))
                                        : Center(
                                            child: Container(
                                              width: 70,
                                              height: 40,
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Cricket_white,
                                                borderRadius: CustomStylesBorder
                                                    .borderRadiusfull,
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                      "images/over.gif"),
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      CustomStylesBorder.boderRadius10,
                                  border: border),
                              width: screenWidth * 0.9,
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    //col1
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("CRR :-",
                                                  style: CustomStyles
                                                      .cardBoldDarkTextStyleblue),
                                              Text(matchDatas.currRate ?? "0",
                                                  style: CustomStyles
                                                      .cardBoldDarkTextStyle2),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Text("RRR :-",
                                                  style: CustomStyles
                                                      .cardBoldDarkTextStyleblue),
                                              Text(matchDatas.rRRate.toString(),
                                                  style: CustomStyles
                                                      .cardBoldDarkTextStyle2),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Text("TARGET :-",
                                                  style: CustomStyles
                                                      .cardBoldDarkTextStyleblue),
                                              Text(matchDatas.target.toString(),
                                                  style: CustomStyles
                                                      .cardBoldDarkTextStyle2),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ),

                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      CustomStylesBorder.boderRadius10,
                                  border: border),
                              width: screenWidth * 0.9,
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //col1
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "${matchDatas.battingTeam == matchDatas.teamAId.toString() ? matchDatas.runneed : matchDatas.result}",
                                                  style: CustomStyles.livefont),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ),

                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      CustomStylesBorder.boderRadius10,
                                  border: border),
                              width: screenWidth * 0.9,
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    //col1
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                  "Fan Team: :-${matchDatas.favTeam ?? "0"}",
                                                  style: CustomStyles
                                                      .smallLightTextStyle2)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                matchDatas.favTeam ?? "0",
                                                style: CustomStyles
                                                    .smallLightTextStyle2,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              smallboxRed(matchDatas.minRate
                                                  .toString()),
                                              smallboxblue(
                                                  matchDatas.maxRate.toString())
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    //col1
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                  "Over  :-${matchDatas.sOvr ?? "0"}",
                                                  style: CustomStyles
                                                      .cardBoldDarkTextStyleblue),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Session:",
                                                style: CustomStyles
                                                    .cardBoldDarkTextStyle2,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              smallboxRed(
                                                  matchDatas.sMin.toString()),
                                              smallboxblue(
                                                  matchDatas.sMax.toString())
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ),

                            Container(
                              height: 290,
                              width: screenWidth * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      CustomStylesBorder.boderRadius10,
                                  border: border),
                              child: MatchDetailsLayout(
                                  batsmen1: matchDatas,
                                  batsmen2: matchDatas,
                                  bowlers: matchDatas),
                            ),

                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      CustomStylesBorder.boderRadius10,
                                  border: border),
                              width: screenWidth * 0.9,
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    //col1
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("Player :-",
                                                  style: CustomStyles
                                                      .cardBoldDarkDrawerTextStyle)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Ball",
                                                style: CustomStyles
                                                    .smallLightTextStyle2,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Run",
                                                style: CustomStyles
                                                    .smallLightTextStyle2,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    //col1
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("P'ship  :-",
                                                  style: CustomStyles
                                                      .cardBoldDarkTextStyleblue),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                matchDatas.partnership!.balls
                                                    .toString(),
                                                style: CustomStyles
                                                    .cardBoldDarkTextStyle2,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                matchDatas.partnership!.runs
                                                    .toString(),
                                                style: CustomStyles
                                                    .cardBoldDarkTextStyle2,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ),

                            Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              decoration: BoxDecoration(
                                  color: Cricket_white,
                                  borderRadius:
                                      CustomStylesBorder.boderRadius10,
                                  border: border),
                              width: screenWidth * 0.9,
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    //col1
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(matchDatas.teamAShort
                                                .toString())
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            smallboxRed(
                                                matchDatas.minRate.toString()),
                                            smallboxblue(
                                                matchDatas.maxRate.toString())
                                          ],
                                        )
                                      ],
                                    ),
                                    //col3
                                    matchDatas.matchType
                                            .toString()
                                            .contains("Test")
                                        ? Column(
                                            children: [
                                              const Row(
                                                children: [Text("DRAW")],
                                              ),
                                              Row(
                                                children: [
                                                  smallboxRed(matchDatas
                                                      .minRate2
                                                      .toString()),
                                                  smallboxblue(matchDatas
                                                      .maxRate2
                                                      .toString())
                                                ],
                                              )
                                            ],
                                          )
                                        : Text(""),

                                    //col3
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(matchDatas.teamBShort
                                                .toString())
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            smallboxRed(
                                                matchDatas.minRate.toString()),
                                            smallboxblue(
                                                matchDatas.maxRate.toString())
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ]),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      CustomStylesBorder.boderRadius10,
                                  border: border),
                              width: screenWidth * 0.9,
                              child: Column(children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Yet to bat ",
                                            style: CustomStyles
                                                .cardBoldDarkDrawerTextStyle)
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${matchDatas.yetToBet != null ? matchDatas.yetToBet!.map((e) => e) : "--"}",
                                      style:
                                          CustomStyles.cardBoldDarkTextStyle2,
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                            // ////////////////////////////////////////////////////////////////session
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      CustomStylesBorder.boderRadius10,
                                  border: border),
                              width: screenWidth * 0.9,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Session ",
                                              style: CustomStyles
                                                  .cardBoldDarkDrawerTextStyle,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: SizedBox(
                                            width: 200,
                                            child: Column(
                                              children: [
                                                HtmlWidget(
                                                  """

                                                                         ${matchDatas.session.toString()}

                                                """,
                                                  textStyle:
                                                      TextStyle(fontSize: 12),
                                                  customStylesBuilder:
                                                      (element) {
                                                    if (element.outerHtml
                                                        .contains('<p>')) {
                                                      return {
                                                        'font-size': '10px',
                                                        'color': 'blue',
                                                        'font-weight': '700',
                                                        "text-align": "center",
                                                      };
                                                    } else {
                                                      return {
                                                        "text-align": "center",
                                                        'font-size': '15px',
                                                        'color': 'blue',
                                                        'margin': '8px 0',
                                                        'font-weight': '700',
                                                      };
                                                    }
                                                  },
                                                ),
                                                Text(convertDataToText(
                                                    matchDatas.session
                                                        .toString())),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ));
            } else {
              // Data is not available, show a progress indicator or loading state
              return SafeArea(
                  child: Center(
                child: summer,
              ));
            }
          },
        ),
      ),
    );
  }
}
