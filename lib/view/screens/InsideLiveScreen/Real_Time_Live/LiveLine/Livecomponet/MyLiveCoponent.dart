import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:sprotbuzz/core/utilis/borderbox.dart';
import 'package:sprotbuzz/core/utilis/boxSpace.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/my_strings.dart';
import 'package:sprotbuzz/view/screens/InsideLiveScreen/Real_Time_Live/RealTimecomponent/RealTimecomponent.dart';

import '../../../../../../core/utilis/style.dart';
import '../../../../../../data/model/home_page_models.dart';
import '../../../../../../data/model/real_time_model/RealTimeModel.dart';
import '../../../../home/home_page_componet/carousel/widget/Widget.dart';
import '../../RealTimecomponent/gifShow.dart';

String? previousText = "";
bool isSoundEnabled = true;
Widget myLiveMatchComponent({
  required context,
  required Function setState,
  required String type,
  required LiveMatchFull matchData,
  required var remainingSeconds,
}) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 90,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: border,
      ),
      child: type != "Upcoming"
          ? buildLiveMatchContent(context, setState, matchData)
          : buildUpcomingMatchContent(context, matchData, remainingSeconds),
    ),
  );
}

Widget buildLiveMatchContent(context, setState, matchData) {
  return Stack(
    children: [
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
            isSoundEnabled ? Icons.volume_up : Icons.volume_off,
            color: Colors.blue,
            size: 19,
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildTeamInfo(context, matchData),
          buildMatchDetails(context, matchData),
        ],
      ),
    ],
  );
}

Widget buildTeamInfo(context, matchData) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildTeamLogoAndName(context, matchData),
      buildTeamScores(context, matchData),
    ],
  );
}

Widget buildTeamLogoAndName(context, matchData) {
  return Column(
    children: [
      Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: boRadiusAll,
          border: border,
          image: DecorationImage(
            image: NetworkImage(matchData.battingTeam == matchData.teamAId.toString()
                ? matchData.teamAImg.toString()
                : matchData.teamBImg.toString()),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 5),
        child: Text(
          matchData.battingTeam.toString() == matchData.teamAId.toString()
              ? matchData.teamAShort.toString()
              : matchData.teamBShort.toString(),
          style: interSemiBoldExtraSmall.copyWith(
            color: MyColor.getTextColor(),
          ),
        ),
      ),
    ],
  );
}

Widget buildTeamScores(context, matchData) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      buildMatchScores(context, matchData),
      buildMatchOver(context, matchData),
    ],
  );
}

Widget buildMatchScores(context, matchData) {
  return matchData.matchType.toString() == "Test"
      ? Container(
          margin: const EdgeInsets.only(right: 10),
          child: Text(
            matchData.battingTeam == matchData.teamAId.toString()
                ? matchData.teamAScores.toString().split("&").last
                : matchData.teamBScore.toString().split("&").last.replaceAll('\n', ''),
            style: interBoldHeader2.copyWith(
              color: MyColor.mycolorGolden,
            ),
          ),
        )
      : Container(
          margin: const EdgeInsets.only(right: 10),
          child: Text(
            matchData.battingTeam == matchData.teamAId.toString()
                ? matchData.teamAScores.toString()
                : matchData.teamBScores.toString(),
            style: interBoldHeader2.copyWith(
              color: MyColor.mycolorGolden,
            ),
          ),
        );
}

Widget buildMatchOver(context, matchData) {
  return matchData.matchType.toString() == "Test"
      ? SizedBox(
          child: Text(
            matchData.battingTeam == matchData.teamAId.toString()
                ? "${matchData.teamAScoresOver!.last.over.toString()} "
                : "${matchData.teamBScoresOver!.last.over.toString()} ",
            style: interBoldDefault.copyWith(
              color: MyColor.getTextColor(),
            ),
          ),
        )
      : matchData.battingTeam == matchData.teamAId
          ? Text(
              "${matchData.teamAOver}",
              style: interBoldDefault.copyWith(
                color: MyColor.getTextColor(),
              ),
            )
          : Text(
              "${matchData.teamBover}",
              style: interBoldDefault.copyWith(
                color: MyColor.getTextColor(),
              ),
            );
}

Widget buildMatchDetails(context, matchData) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      buildMatchEvent(context, matchData),
    ],
  );
}

Widget buildMatchEvent(context, matchData) {
  if (matchData.firstCircle.toString().contains("Six")) {
    return buildSixGif();
  } else if (matchData.firstCircle.toString().contains("four")) {
    return buildFourGif();
  } else {
    return buildMatchText(matchData,context);
  }
}

Widget buildSixGif() {
  return Center(
    child: Container(
      width: 100,
      height: 60,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColor.getCardBg(),
        borderRadius: boRadius5,
        image: const DecorationImage(
          image: AssetImage("assets/six.gif"),
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}

Widget buildFourGif() {
  return Center(
    child: Container(
      width: 100,
      height: 60,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColor.getCardBg(),
        borderRadius: boRadius5,
        image: const DecorationImage(
          image: AssetImage("assets/four.gif"),
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}

Widget buildMatchText(matchData,context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.3,
    child: Text(
      truncateText(matchData.firstCircle.toString().replaceAll('\n', ''), 15),
      style: interBoldExtraLarge.copyWith(
        color: MyColor.getTextColor(),
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget buildUpcomingMatchContent(context, matchData, remainingSeconds) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.8,
    child: Column(
      children: [
        Text(
          matchData.matchType,
          style: InterSemiBold.copyWith(
            color: MyColor.getTextColor(),
          ),
        ),
        CountdownTimerWidget(
          totalSeconds: remainingSeconds,
        ),
      ],
    ),
  );
}






































//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ignore: must_be_immutable
class FinshMatchInLive extends StatefulWidget {
  final String type;
  LiveMatchFull matchData;
  LiveMatch Data;
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

    return Container(
      height: 100,
      width: screenWidth * 0.9,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: border,
        borderRadius: boRadiusAll,
      ),
      child: Stack(children: [
        Positioned(
            top: 0,
            left: 160,
            child: Text(
              "${widget.matchData.matchType}",
              style: interSemiBoldOverSmall.copyWith(
                  color: MyColor.getTextColor()),
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
                    style: interSemiBoldOverSmall.copyWith(
                        color: MyColor.getTextColor()),
                    textAlign: TextAlign.center,
                  ),
                ),
                size10h,
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
                        style: interSemiBoldOverSmall.copyWith(
                            color: MyColor.getTextColor()),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ScoresBox(
                          widget.Data.teamAScore.toString().toString(), "A"),
                      Text(
                        "Over : ${widget.Data.teamAOver.toString()} ",
                        style: interSemiBoldOverSmall.copyWith(
                            color: MyColor.getTextColor1()),
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
                        style: interSemiBoldOverSmall.copyWith(
                            color: MyColor.getTextColor()),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ScoresBox(widget.Data.teamBScore.toString(), "B"),
                      Text(
                        "Over : ${widget.Data.teamBOver.toString()}",
                        style: interSemiBoldOverSmall.copyWith(
                            color: MyColor.getTextColor()),
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

// ignore: must_be_immutable
class PiPComponet extends StatefulWidget {
  final String type;
  var matchData;
  var remainingSeconds;
  PiPComponet(
      {super.key,
      required this.type,
      required this.matchData,
      required this.remainingSeconds});

  @override
  State<PiPComponet> createState() => _PiPComponetState();
}

class _PiPComponetState extends State<PiPComponet> {
  bool isSoundEnabled = false;

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    List<Widget> widgetsTeamScore = [];
    return Container(
      height: screenWidth * 0.3,
      width: screenWidth * 0.9,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: boRadius5,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: screenWidth * 0.9,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: MyColor.getTextColor(),
              borderRadius: boRadiusAll,
              border: border),
          height: 310,
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  left: 160,
                  child: Text(
                    "${widget.matchData.matchType}",
                    style: interSemiBoldOverSmall.copyWith(
                        color: MyColor.getTextColor()),
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
                    isSoundEnabled ? Icons.volume_up : Icons.volume_off,
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
                              borderRadius: boRadiusAll,
                              border: border,
                              image: DecorationImage(
                                image: NetworkImage(
                                    widget.matchData.battingTeam ==
                                            widget.matchData.teamAId.toString()
                                        ? widget.matchData.teamAImg.toString()
                                        : widget.matchData.teamBImg.toString()),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Text(
                                      widget.matchData.battingTeam.toString() ==
                                              widget.matchData.teamAId
                                                  .toString()
                                          ? widget.matchData.teamAShort
                                              .toString()
                                          : widget.matchData.teamBShort
                                              .toString(),
                                      style: interSemiBoldOverSmall.copyWith(
                                          color: MyColor.getTextColor()))),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 84,
                                    child: Text(
                                        widget.matchData.battingTeam
                                                    .toString() ==
                                                widget.matchData.teamAId
                                                    .toString()
                                            ? widget.matchData.teamAScores
                                                .toString()
                                                .split("&")[0]
                                            : widget.matchData.teamBScore
                                                .toString()
                                                .split("&")[0]
                                                .replaceAll('\n', ''),
                                        style: interSemiBoldOverSmall.copyWith(
                                            color: MyColor.getTextColor())),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 10, left: 5),
                                    child: Text(
                                        widget.matchData.battingTeam ==
                                                widget.matchData.teamAId
                                            ? widget.matchData.teamAOver
                                                .toString()
                                            : widget.matchData.teamBover
                                                .toString()
                                                .split("&")[0],
                                        style: interSemiBoldOverSmall.copyWith(
                                            color: MyColor.getTextColor())),
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
                      widget.matchData.firstCircle.toString().contains("Six") ||
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
                                style: interSemiBoldOverSmall.copyWith(
                                    color: MyColor.getTextColor()),
                                textAlign: TextAlign.center,
                              ),
                            )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

smallboxRed(value) {
  return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(2),
      height: 24,
      width: 35,
      decoration: BoxDecoration(
        borderRadius: boRadiusAll,
        border: border,
        color: MyColor.pendingColor,
      ),
      child: Text(
        value.toString(),
        style: interBoldDefault.copyWith(color: MyColor.bgColorLight),
      ));
}
