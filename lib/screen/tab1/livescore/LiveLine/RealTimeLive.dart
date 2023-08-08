import 'dart:async';
import 'dart:convert';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mycricketline/screen/tab1/livescore/LiveLine/BatBowler.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';

import 'package:http/http.dart' as http;

import '../../../../AipProvider/LiveMatch.dart';
import '../../../../AipProvider/ThemeProvider.dart';
import '../../../../model/Livematch.dart';
import '../../../../utils/Color.dart';
import '../../../../utils/CustomWidget/Countdown.dart';
import '../../../../utils/CustomWidget/Dotetext.dart';
import '../../../../utils/CustomWidget/Externel.dart';

import '../../../../utils/CustomWidget/htmlntoText.dart';
import '../../../../utils/CustomWidget/shimmer.dart';
import '../../../../utils/Style.dart';

LiveMatchData? liveMatchData;

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
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    // Info Data
    var Infoprovider = Provider.of<InfoProvider>(context);
    Infoprovider.fetchLiveMatchesFullDataInfo(widget.idMatch);
    var mayInfoData = Infoprovider.infoMatches;

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
                  children: liveMatches.asMap().entries.map((matchDatas) {
                    int index = matchDatas.key;
                    LiveMatchFull matchData = matchDatas.value;

                    speak(matchData.firstCircle.toString());
                    previousText = matchData.firstCircle;
//////////////////////////////////////////////////////////////////////

                    final matchDateTime = parseMatchDateTime(
                        mayInfoData[index].matchDate.toString(),
                        mayInfoData[index].matchTime.toString());

                    final remainingSeconds =
                        calculateRemainingSeconds(matchDateTime);

                    List<String> textArray =
                        extractTextFromHtml(matchData.session);

                    //////////////////////////////////////////////////////////////////////

                    if (matchData.firstCircle.toString().contains("Six")) {
                      widgetsTeamScore.add(Text(""));

                      widgetsTeamScore.add(
                        Center(
                          child: Container(
                            width: 100,
                            height: 60,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: themeProvider.isDarkTheme
                                  ? CustomColor.cricketWhite
                                  : CustomColor.cricketBlackColor,
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

                    if (matchData.firstCircle.toString().contains("four")) {
                      widgetsTeamScore.add(Text(""));
                      widgetsTeamScore.add(
                        Center(
                          child: Container(
                            width: 100,
                            height: 60,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: themeProvider.isDarkTheme
                                  ? CustomColor.cricketWhite
                                  : CustomColor.cricketBlackColor,
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
                        matchData.result != "" && widget.type != "Upcoming"
                            ? Container(
                                height: 100,
                                width: screenWidth * 0.9,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: border,
                                  boxShadow: [boxshadow],
                                  color: themeProvider.isDarkTheme
                                      ? CustomColor.cricketWhite
                                      : CustomColor.cricketBlackColor,
                                  borderRadius:
                                      CustomStylesBorder.boderRadius10,
                                ),
                                child: Stack(children: [
                                  Positioned(
                                      top: 0,
                                      left: 160,
                                      child: Text(
                                        "${matchData.matchType}",
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
                                              matchData.firstCircle.toString(),
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
                                                  matchData.teamAShort
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
                                                  matchData.teamBShort
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
                                height: screenWidth * 0.3,
                                width: screenWidth * 0.9,
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      CustomStylesBorder.boderRadius10,
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                      width: screenWidth * 0.9,
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: CustomColor.cricketPrimary,
                                          borderRadius:
                                              CustomStylesBorder.boderRadius10,
                                          border: border),
                                      height: 310,
                                      child: widget.type != "Upcoming"
                                          ? Stack(
                                              children: [
                                                Positioned(
                                                    top: 0,
                                                    left: 160,
                                                    child: Text(
                                                      "${matchData.matchType}",
                                                      style: CustomStyles
                                                          .normalTextStyle2,
                                                    )),
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: InkWell(
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
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 30,
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 5,
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    CustomStylesBorder
                                                                        .borderRadiusfull,
                                                                border: border,
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(matchData
                                                                              .battingTeam ==
                                                                          matchData
                                                                              .teamAId
                                                                              .toString()
                                                                      ? matchData
                                                                          .teamAImg
                                                                          .toString()
                                                                      : matchData
                                                                          .teamBImg
                                                                          .toString()),
                                                                  fit: BoxFit
                                                                      .fitHeight,
                                                                ),
                                                              ),
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            10),
                                                                    child: Text(
                                                                        matchData.battingTeam.toString() == matchData.teamAId.toString()
                                                                            ? matchData.teamAShort
                                                                                .toString()
                                                                            : matchData.teamBShort
                                                                                .toString(),
                                                                        style: CustomStyles
                                                                            .cardBoldDarkTextStyleWhite)),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Container(
                                                                      width: 84,
                                                                      child: Text(
                                                                          matchData.battingTeam.toString() == matchData.teamAId.toString()
                                                                              ? matchData.teamAScores.toString().split("&")[0]
                                                                              : matchData.teamBScore.toString().split("&")[0].replaceAll('\n', ''),
                                                                          style: CustomStyles.grayTextStyle),
                                                                    ),
                                                                    Container(
                                                                      margin: const EdgeInsets
                                                                              .only(
                                                                          bottom:
                                                                              10,
                                                                          left:
                                                                              5),
                                                                      child: Text(
                                                                          matchData.battingTeam == matchData.teamAId
                                                                              ? matchData.teamAOver.toString()
                                                                              : matchData.teamBover.toString().split("&")[0],
                                                                          style: CustomStyles.overmontserratwhite),
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
                                                      decoration:
                                                          const BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              "images/Line1.png"),
                                                          fit: BoxFit.fitHeight,
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        matchData.firstCircle
                                                                    .toString()
                                                                    .contains(
                                                                        "Six") ||
                                                                matchData
                                                                    .firstCircle
                                                                    .toString()
                                                                    .contains(
                                                                        "0")
                                                            ? Row(
                                                                children:
                                                                    widgetsTeamScore,
                                                              )
                                                            : Container(
                                                                width:
                                                                    screenWidth *
                                                                        0.3,
                                                                child: Text(
                                                                  truncateText(
                                                                      matchData
                                                                          .firstCircle
                                                                          .toString()
                                                                          .replaceAll(
                                                                              '\n',
                                                                              ''),
                                                                      15),
                                                                  style: CustomStyles
                                                                      .firstCircle,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                    matchData.matchType,
                                                    style: CustomStyles
                                                        .cardBoldTextStyle,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          CustomStylesBorder
                                                              .boderRadius10,
                                                      color: CustomColor
                                                          .cricketWhite,
                                                      border: border,
                                                    ),
                                                    child: CountdownTimerWidget(
                                                        totalSeconds:
                                                            remainingSeconds),
                                                  )
                                                ],
                                              ),
                                            )),
                                )),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                  color: themeProvider.isDarkTheme
                                      ? CustomColor.cricketWhite
                                      : CustomColor.cricketBlackColor,
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
                                    matchData.last36Ball != null
                                        ? Row(
                                            children: List.generate(
                                                matchData.last4Overs!.last.ball
                                                    .length, (index) {
                                            var qover =
                                                matchData.last4Overs!.last;
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
                                                  color: themeProvider
                                                          .isDarkTheme
                                                      ? CustomColor.cricketWhite
                                                      : CustomColor
                                                          .cricketBlackColor,
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
                                                color: themeProvider.isDarkTheme
                                                    ? CustomColor.cricketWhite
                                                    : CustomColor
                                                        .cricketBlackColor,
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
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 15),
                              decoration: BoxDecoration(
                                  color: themeProvider.isDarkTheme
                                      ? CustomColor.cricketWhite
                                      : CustomColor.cricketBlackColor,
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
                                              Text(matchData.currRate ?? "0",
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
                                              Text(matchData.rRRate.toString(),
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
                                              Text(matchData.target.toString(),
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
                                  color: themeProvider.isDarkTheme
                                      ? CustomColor.cricketWhite
                                      : CustomColor.cricketBlackColor,
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
                                                  "${matchData.battingTeam == matchData.teamAId.toString() ? matchData.teamA : matchData.teamB} Need ${matchData.battingTeam == matchData.teamAId.toString() ? matchData.runneed : matchData.result}",
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
                                  color: themeProvider.isDarkTheme
                                      ? CustomColor.cricketWhite
                                      : CustomColor.cricketBlackColor,
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
                                                  "Fan Team: :-${matchData.favTeam ?? "0"}",
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
                                                matchData.favTeam ?? "0",
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
                                              smallboxRed(
                                                  matchData.minRate.toString()),
                                              smallboxblue(
                                                  matchData.maxRate.toString())
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
                                                  "Over  :-${matchData.sOvr ?? "0"}",
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
                                                  matchData.sMin.toString()),
                                              smallboxblue(
                                                  matchData.sMax.toString())
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
                                  color: themeProvider.isDarkTheme
                                      ? CustomColor.cricketWhite
                                      : CustomColor.cricketBlackColor,
                                  borderRadius:
                                      CustomStylesBorder.boderRadius10,
                                  border: border),
                              child: MatchDetailsLayout(
                                  batsmen1: matchData,
                                  batsmen2: matchData,
                                  bowlers: matchData),
                            ),

                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 15),
                              decoration: BoxDecoration(
                                  color: themeProvider.isDarkTheme
                                      ? CustomColor.cricketWhite
                                      : CustomColor.cricketBlackColor,
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
                                                matchData.partnership!.balls
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
                                                matchData.partnership!.runs
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
                                  color: themeProvider.isDarkTheme
                                      ? CustomColor.cricketWhite
                                      : CustomColor.cricketBlackColor,
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
                                            Text(
                                                matchData.teamAShort.toString())
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            smallboxRed(
                                                matchData.minRate.toString()),
                                            smallboxblue(
                                                matchData.maxRate.toString())
                                          ],
                                        )
                                      ],
                                    ),
                                    //col3
                                    matchData.matchType
                                            .toString()
                                            .contains("Test")
                                        ? Column(
                                            children: [
                                              const Row(
                                                children: [Text("DRAW")],
                                              ),
                                              Row(
                                                children: [
                                                  smallboxRed(matchData.minRate2
                                                      .toString()),
                                                  smallboxblue(matchData
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
                                            Text(
                                                matchData.teamBShort.toString())
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            smallboxRed(
                                                matchData.minRate.toString()),
                                            smallboxblue(
                                                matchData.maxRate.toString())
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
                                  color: themeProvider.isDarkTheme
                                      ? CustomColor.cricketWhite
                                      : CustomColor.cricketBlackColor,
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
                                      "${matchData.yetToBet != null ? matchData.yetToBet!.map((e) => e) : "--"}",
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
                                  color: themeProvider.isDarkTheme
                                      ? CustomColor.cricketWhite
                                      : CustomColor.cricketBlackColor,
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
                                                //  buildColumn(textArray)
                                                myHtmlWidget(matchData.session)
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
