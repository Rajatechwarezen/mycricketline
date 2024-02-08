import 'dart:async';
import 'dart:convert';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprotbuzz/core/utilis/borderbox.dart';
import 'package:sprotbuzz/view/component/custom_loader/custom_loader.dart';
import 'package:sprotbuzz/view/component/html/htmlComp.dart';
import 'package:sprotbuzz/view/screens/InsideLiveScreen/Real_Time_Live/LiveLine/BatBowler.dart';
import 'package:sprotbuzz/view/screens/InsideLiveScreen/Real_Time_Live/LiveLine/Livecomponet/MyLiveCoponent.dart';
import 'package:sprotbuzz/view/screens/InsideLiveScreen/Real_Time_Live/RealTimecomponent/RealTimecomponent.dart';

import '../../../../core/utilis/my_color.dart';
import '../../../../core/utilis/style.dart';
import '../../../../data/controller/Real_Time_Controller/RealTimeController.dart';
import '../../../../data/model/home_page_models.dart';
import '../../../../data/model/real_time_model/RealTimeModel.dart';
import '../../../../data/repo/RealTimeRepo/real_Time_Repo.dart';
import '../../../../data/servies/api_service.dart';
import '../../../component/divider/custom_divider.dart';

class RealTimeLiveScreen extends StatefulWidget {
  final int idMatch;
  final LiveMatch? allData;
  final String type;
  // final dynamic Data;

  RealTimeLiveScreen({
    required this.idMatch,
    required this.allData,
    required this.type,

    // this.Data
  });

  @override
  State<RealTimeLiveScreen> createState() => _RealTimeLiveScreenState();
}

class _RealTimeLiveScreenState extends State<RealTimeLiveScreen> {
  late Timer timer;
  RealTimeController realTimeDataController = Get.put(
      RealTimeController(realTimeRepo: RealTimeRepo(apiClient: Get.find())));

  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(RealTimeRepo(apiClient: Get.find()));
    realTimeDataController.initData(widget.idMatch);

    // Set up the timer to fetch data every 2 seconds
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        realTimeDataController.initData(widget.idMatch);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Obx(() => realTimeDataController.isLoading.value
        ? const CustomLoader()
        : SafeArea(
            child: Scaffold(
                body: SingleChildScrollView(
            child: Column(
              children: realTimeDataController.allLiveMatches
                  .asMap()
                  .entries
                  .map((matchDatas) {
                LiveMatchFull matchData = matchDatas.value;
                // print(matchData);
                var document = extractTextFromHtml(matchData.session);
                //////////////////////////////////////////////////////////////////////

                final matchDateTime = parseMatchDateTime(
                    widget.allData!.matchDate.toString(),
                    widget.allData!.matchTime.toString());

                final remainingSeconds =
                    calculateRemainingSeconds(matchDateTime);

                //////////////////////////////////////////////////////////////////////

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //////main live
                      matchData.result != "" && widget.type != "Upcoming"
                          ? FinshMatchInLive(
                              matchData: matchData,
                              Data: widget.allData!, //widget.Data
                              type: widget.type,
                            )
                          : myLiveMatchComponent(
                              setState: setState,
                              context: context,
                              type: widget.type,
                              matchData: matchData,
                              remainingSeconds: remainingSeconds,
                            ),
                    
                    
                    
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          cardBoxUi(
                            screenWidth: screenWidth,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(
                                    "Over :",
                                    style: interSemiBoldDefault.copyWith(
                                      color: MyColor.getTextColor(),
                                    ),
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
                                              padding: const EdgeInsets.all(5),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                color: MyColor.getCardBg(),
                                                borderRadius: boRadiusAll,
                                                border: border,
                                              ),
                                              width: 30,
                                              height: 25,
                                              child: Text(
                                                myoverball.toString() ?? '0',
                                                style: interSemiBoldDefault
                                                    .copyWith(
                                                  color: MyColor.getTextColor(),
                                                ),
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
                                              color: MyColor.getCardBg(),
                                              borderRadius: boRadiusAll,
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

                          cardBoxUi(
                            screenWidth: screenWidth,
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
                                                style: interLightExtraSmall
                                                    .copyWith(
                                                        color: MyColor
                                                            .getTextColor())),
                                            Text(matchData.currRate ?? "0",
                                                style: interLightExtraSmall
                                                    .copyWith(
                                                        color: MyColor
                                                            .getTextColor())),
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
                                                style: interLightExtraSmall
                                                    .copyWith(
                                                        color: MyColor
                                                            .getTextColor())),
                                            Text(matchData.rRRate.toString(),
                                                style: interLightExtraSmall
                                                    .copyWith(
                                                        color: MyColor
                                                            .getTextColor())),
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
                                                style: interLightExtraSmall
                                                    .copyWith(
                                                        color: MyColor
                                                            .getTextColor())),
                                            Text(matchData.target.toString(),
                                                style: interLightExtraSmall
                                                    .copyWith(
                                                        color: MyColor
                                                            .getTextColor())),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),

                          cardBoxUi(
                            screenWidth: screenWidth,
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
                                                style: interLightExtraSmall
                                                    .copyWith(
                                                        color: MyColor
                                                            .getTextColor())),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),

                          cardBoxUi(
                            screenWidth: screenWidth,
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
                                                style: interLightExtraSmall
                                                    .copyWith(
                                                        color: MyColor
                                                            .getTextColor()))
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
                                              style:
                                                  interLightExtraSmall.copyWith(
                                                      color: MyColor
                                                          .getTextColor()),
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
                                            smallboxRed(
                                                matchData.maxRate.toString())
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const CustomDivider(),
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
                                                style: interLightExtraSmall
                                                    .copyWith(
                                                        color: MyColor
                                                            .getTextColor())),
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
                                              style:
                                                  interLightExtraSmall.copyWith(
                                                      color: MyColor
                                                          .getTextColor()),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // smallboxRed(
                                            //     matchData.sMin.toString()),
                                            // smallboxblue(
                                            //     matchData.sMax.toString())
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
                          color:MyColor.getCardBg(),
                                borderRadius:
                                   boRadiusAll,
                                border: border),
                            child: MatchDetailsLayout(
                                batsmen1: matchData,
                                batsmen2: matchData,
                                bowlers: matchData),
                          ),

                          cardBoxUi(
                            screenWidth: screenWidth,
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
                                                style: interSemiBoldDefault
                                                    .copyWith(
                                                  color: MyColor.getTextColor(),
                                                ))
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
                                              style:
                                                  interSemiBoldDefault.copyWith(
                                                color: MyColor.getTextColor(),
                                              ),
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
                                              style:
                                                  interSemiBoldDefault.copyWith(
                                                color: MyColor.getTextColor(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const CustomDivider(),
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
                                            Text("P'ship :",
                                                style: interLightExtraSmall
                                                    .copyWith(
                                                        color: MyColor
                                                            .getTextColor())),
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
                                              style:
                                                  interSemiBoldDefault.copyWith(
                                                color: MyColor.getTextColor(),
                                              ),
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
                                              style:
                                                  interSemiBoldDefault.copyWith(
                                                color: MyColor.getTextColor(),
                                              ),
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

                          cardBoxUi(
                            screenWidth: screenWidth,
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
                                          Text(matchData.teamAShort.toString(),
                                              style:
                                                  interBoldExtraSmall.copyWith(
                                                color: MyColor.getTextColor(),
                                              ))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          smallboxRed(
                                              matchData.minRate.toString()),
                                          smallboxRed(
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
                                            Row(
                                              children: [
                                                Text(
                                                  "DRAW",
                                                  style: interBoldExtraSmall
                                                      .copyWith(
                                                    color:
                                                        MyColor.getTextColor(),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                smallboxRed(matchData.minRate2
                                                    .toString()),
                                                smallboxRed(matchData.maxRate2
                                                    .toString())
                                              ],
                                            )
                                          ],
                                        )
                                      : const Text(""),

                                  //col3
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            matchData.teamBShort.toString(),
                                            style: interBoldExtraSmall.copyWith(
                                              color: MyColor.getTextColor(),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          smallboxRed(
                                              matchData.minRate.toString()),
                                          smallboxRed(
                                              matchData.maxRate.toString())
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ]),
                          ),
                          cardBoxUi(
                            screenWidth: screenWidth,
                            child: Column(children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text("Yet to bat ",
                                          style: interSemiBoldDefault.copyWith(
                                            color: MyColor.getTextColor1(),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                              const CustomDivider(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      "${matchData.yetToBet != null ? matchData.yetToBet!.map((e) => e) : "--"}",
                                      style: interSemiBoldDefault.copyWith(
                                        color: MyColor.getTextColor(),
                                      )),
                                ],
                              ),
                            ]),
                          ),
                          //Session =================================================
                          cardBoxUi(
                            screenWidth: screenWidth,
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
                                            style:
                                                interSemiBoldDefault.copyWith(
                                                    color: MyColor
                                                        .getTextColor1()),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const CustomDivider(),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: SizedBox(
                                          width: 200,
                                          child: Column(
                                            children: [
                                              //  buildColumn(textArray)

                                              Text(
                                                document.toString(),
                                                style: interSemiBoldDefault
                                                    .copyWith(
                                                        color: MyColor
                                                            .getTextColor()),
                                              ),
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
                  ),
                );
              }).toList(),
            ),
          ))));
  }
}

cardBoxUi({Widget? child, screenWidth}) {
  return Container(
    padding: const EdgeInsets.all(5),
    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
    decoration: BoxDecoration(
        color: MyColor.getCardBg(), borderRadius: boRadiusAll, border: border),
    child: child!,
    width: screenWidth * 0.9,
  );
}
