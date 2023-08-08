// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mycricketline/utils/Color.dart';
import 'package:mycricketline/utils/Style.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../../AipProvider/LiveMatch.dart';
import '../../../../AipProvider/ThemeProvider.dart';
import '../../../../model/player.dart';
import '../../../../utils/CustomWidget/Dotetext.dart';
import '../../../../utils/CustomWidget/shimmer.dart';
import '../LiveCustom.dart';
import '../LiveLine/OnlineLivTape.dart';

class Info extends StatefulWidget {
  var id;
  var type;

  Info({
    super.key,
    required this.type,
    required this.id,
  });

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    final screenWidth = MediaQuery.of(context).size.width;
    var Infoprovider = Provider.of<InfoProvider>(context);
    Infoprovider.fetchLiveMatchesFullDataInfo(widget.id);
    var infoData = Infoprovider.infoMatches;

    if (infoData.isEmpty) {
      return infoData == [] || infoData == "[]"
          ? summer2
          : Center(
              child: Lottie.asset(
                'assets/animation.json', // Path to your JSON animation file
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Column(
              children: infoData.map(
                (Data) {
                  return Column(
                    children: [
                      if (Data.toss == " ")
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                              color: themeProvider.isDarkTheme
                                  ? CustomColor.cricketWhite
                                  : CustomColor.cricketBlackColor,
                              borderRadius: CustomStylesBorder.boderRadius10,
                              border: border),
                          width: screenWidth * 0.9,
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(Data.toss == " "
                                    ? "${widget.type}"
                                    : Data.toss),
                                Container(
                                    height: 30,
                                    width: 30,
                                    margin: const EdgeInsets.only(
                                      left: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          CustomStylesBorder.borderRadiusfull,
                                      image: const DecorationImage(
                                        image: AssetImage("images/toss.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ))
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
                              borderRadius: CustomStylesBorder.boderRadius10,
                              border: border)),
                      ///////////////////team show
                      SizedBox(
                          height: 90,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                showDragHandle: true,
                                useSafeArea: true,
                                isScrollControlled: true,
                                elevation: 8,
                                context: context,
                                builder: (BuildContext context) {
                                  return CricketPlayerList(
                                    id: widget.id,
                                  );
                                },
                              );
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: themeProvider.isDarkTheme
                                    ? CustomColor.cricketWhite
                                    : CustomColor.cricketBlackColor,
                                border: border,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  sizeboxSmallh,
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              teamImage2(Data.teamAImg),
                                              sizeboxSmallw,
                                              Text(Data.teamA,
                                                  style: CustomStyles
                                                      .cardBoldTextStyle2),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        child: Icon(
                                          Icons.arrow_circle_right_sharp,
                                          size: 20,
                                          color: CustomColor.cricketBlackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              teamImage2(Data.teamBImg),
                                              sizeboxSmallw,
                                              Text(Data.teamB,
                                                  style: CustomStyles
                                                      .cardBoldTextStyle2),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  sizeboxSmallh,
                                ],
                              ),
                            ),
                          )),

                      sizeboxSmallh,
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                            color: themeProvider.isDarkTheme
                                ? CustomColor.cricketWhite
                                : CustomColor.cricketBlackColor,
                            borderRadius: CustomStylesBorder.boderRadius10,
                            border: border),
                        width: screenWidth * 0.9,
                        child: Column(children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("Match Detail",
                                          style: CustomStyles
                                              .cardBoldDarkDrawerTextStyle)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Series",
                                          style: CustomStyles
                                              .smallLightTextStylebold2)
                                    ],
                                  ),
                                  sizeboxSmallh,
                                  SizedBox(
                                    width: 300,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("${Data.series}"),
                                          Divider(),
                                        ]),
                                  ),
                                  Divider(),
                                  sizeboxSmallh,
                                  Row(
                                    children: [
                                      Text("Match",
                                          style: CustomStyles
                                              .smallLightTextStylebold2)
                                    ],
                                  ),
                                  sizeboxSmallh,
                                  SizedBox(
                                    width: 300,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${Data.teamA} VS ${Data.teamB}"),
                                          Divider(),
                                        ]),
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Text("Date ",
                                          style: CustomStyles
                                              .smallLightTextStylebold2)
                                    ],
                                  ),
                                  sizeboxSmallh,
                                  SizedBox(
                                    width: 300,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [Text(" ${Data.matchDate} ")],
                                    ),
                                  ),
                                  sizeboxSmallh,
                                  Row(
                                    children: [
                                      Text("Time ",
                                          style: CustomStyles
                                              .smallLightTextStylebold2)
                                    ],
                                  ),
                                  sizeboxSmallh,
                                  SizedBox(
                                    width: 300,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [Text(" ${Data.matchTime} ")],
                                    ),
                                  ),
                                  sizeboxSmallh,
                                  Row(
                                    children: [
                                      Text("Match No  ",
                                          style: CustomStyles
                                              .smallLightTextStylebold2)
                                    ],
                                  ),
                                  sizeboxSmallh,
                                  SizedBox(
                                    width: 300,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [Text("${Data.match} ")],
                                    ),
                                  ),
                                  sizeboxSmallh,
                                  Row(
                                    children: [
                                      Text("venu ",
                                          style: CustomStyles
                                              .smallLightTextStylebold2)
                                    ],
                                  ),
                                  sizeboxSmallh,
                                  SizedBox(
                                    width: 300,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [Text("${Data.venue}")],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ]),
                      ),
                      // ////////////////////////////////////////////////////////////////yetToBet

                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                            color: themeProvider.isDarkTheme
                                ? CustomColor.cricketWhite
                                : CustomColor.cricketBlackColor,
                            borderRadius: CustomStylesBorder.boderRadius10,
                            border: border),
                        width: screenWidth * 0.9,
                        child: Column(children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("Rafree/Umpire",
                                          style: CustomStyles
                                              .cardBoldDarkDrawerTextStyle)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Rafree:",
                                          style: CustomStyles
                                              .smallLightTextStylebold2),
                                    ],
                                  ),
                                  sizeboxSmallh,
                                  SizedBox(
                                    width: 300,
                                    child: Column(children: [
                                      Text("${Data.referee}"),
                                      Divider(),
                                    ]),
                                  ),
                                  sizeboxSmallh,
                                  Row(
                                    children: [
                                      Text("Umpire: ",
                                          style: CustomStyles
                                              .smallLightTextStylebold2),
                                    ],
                                  ),
                                  sizeboxSmallh,
                                  SizedBox(
                                    width: 300,
                                    child: Column(
                                      children: [
                                        Text(" ${Data.umpire}"),
                                        Divider(),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text("Thire Umpire : ",
                                          style: CustomStyles
                                              .smallLightTextStylebold2),
                                      Divider(),
                                    ],
                                  ),
                                  sizeboxSmallh,
                                  SizedBox(
                                    width: 300,
                                    child: Column(
                                      children: [
                                        Text(" ${Data.thirdUmpire}" ?? " "),
                                        Divider(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ],
                  );
                },
              ).toList(),
            ),
          ],
        ),
      );
    }
  }
}

class CricketPlayerList extends StatefulWidget {
  final int id;

  CricketPlayerList({Key? key, required this.id}) : super(key: key);

  @override
  State<CricketPlayerList> createState() => _CricketPlayerListState();
}

class _CricketPlayerListState extends State<CricketPlayerList> {
  bool isPlayerListVisible = true;

  @override
  Widget build(BuildContext context) {
    final playerMatchProvider = Provider.of<PlayerProvider>(context);
    playerMatchProvider.PlayerMatchesFullData(widget.id.toString());

    MatchData? matchData = playerMatchProvider.player;
    if (matchData == null) {
      return summer;
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: 1800,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 2, // Assuming there are two teams in the match
            itemBuilder: (context, index) {
              TeamData teamData =
                  (index == 0) ? matchData.teamA : matchData.teamB;
              return Container(
                width: 170,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isPlayerListVisible = !isPlayerListVisible;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(teamData.flag),
                              radius: 20,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  teamData.shortName,
                                  style: CustomStyles.cardTextStyle2,
                                ),
                              ],
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                      color: CustomColor.cricketShadowColor,
                    ),
                    if (isPlayerListVisible)
                      Column(
                        children: teamData.players!.map((player) {
                          return ListTile(
                            isThreeLine: true,
                            dense: true,
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(player.image),
                              radius: 20,
                            ),
                            title: Text(player.name,
                                style: CustomStyles.smallTextStyle2),
                            subtitle: Text(player.playRole,
                                style: CustomStyles.smallLightTextStylebold2),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    }
  }
}

void _navigateToPlayerList(BuildContext context, TeamData teamData) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => playerListPage(teamData),
    ),
  );
}

playerListPage(teamData) {
  return ListView.builder(
    itemCount: teamData.players?.length ?? 0,
    itemBuilder: (context, index) {
      PlayerData player = teamData.players![index];
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(player.image),
          radius: 10,
        ),
        title: Text(player.name, style: CustomStyles.smallLightTextStylebold2),
        subtitle: Text(
          player.playRole,
          style: CustomStyles.cardTextStyle2,
        ),
      );
    },
  );
}
