import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprotbuzz/core/utilis/borderbox.dart';
import 'package:sprotbuzz/core/utilis/boxSpace.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/style.dart';
import 'package:sprotbuzz/view/component/custom_loader/custom_loader.dart';
import 'package:sprotbuzz/view/screens/InsideLiveScreen/Commentery/commentery.dart';
import 'package:sprotbuzz/view/screens/InsideLiveScreen/Real_Time_Live/LiveLine/Livecomponet/MyLiveCoponent.dart';
import '../../../../data/controller/oddTable_controller/oddTable_controller.dart';
import '../../../../data/controller/pointTable_controller/poitntTable_controller.dart';
import '../../../../data/model/odds_model/OddsData.dart';
import '../../../../data/repo/PointTable_repo/PointTableRepo.dart';
import '../../../../data/repo/oddTable_repo/oddTableRepo.dart';

class OddTableSreen extends StatefulWidget {
  final idmatch;

  const OddTableSreen({super.key, required this.idmatch});

  @override
  State<OddTableSreen> createState() => _OddTableSreenState();
}

class _OddTableSreenState extends State<OddTableSreen> {
  final OddController allmatchesController = Get.put(OddController(
      oddTableRepo: OddTableRepo(apiClient: Get.find())));

  @override
  void initState() {
    super.initState();
    allmatchesController.fetchOddTableData(matchId: widget.idmatch.toString());

  }

bool _isFirstInning = true;

  void _toggleInning() {
    setState(() {
      _isFirstInning = !_isFirstInning;
    });
  }


  @override
  Widget build(BuildContext context) {
  


    List<CricketMatchOdds>? _currentMatch = [];
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: _toggleInning,
            child: _currentMatch != null
                ? customboxbutton2(
                    _isFirstInning ? 'Second Inning' : 'First Inning')
                : null,
          ),
          const SizedBox(height: 16),
          _currentMatch != null
              ? Column(
                  children: _currentMatch.map((currentMatch) {
                    return Container(
                      margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                      padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                      decoration: BoxDecoration(
                        color: MyColor.getCardBg(),
                        border: border,
                        borderRadius: boRadius5,
                       
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                          height: 30,
                                          width: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: MyColor.getCardBg(),
                                              borderRadius: boRadiusAll),
                                          child: Text(
                                            currentMatch.runs.toString(),
                                            style: interBoldDefault.copyWith(color: MyColor.getTextColor()),
                                          )),
                                      size10h,
                                      Text(
                                        currentMatch.time.toString(),
                                        style:
                                           interBoldDefault.copyWith(color: MyColor.getTextColor()),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text(currentMatch.score.toString()),
                                      const SizedBox(height: 10),
                                      size10h,
                                      Text(
                                        currentMatch.overs.toString(),
                                        style:  interBoldDefault.copyWith(color: MyColor.getTextColor())
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          /////////
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              border: border,
                              borderRadius: boRadiusAll,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Team: ${currentMatch.team.toString()}',
                                  style: interBoldDefault.copyWith(color: MyColor.getTextColor()),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        //1
                                        Column(children: [
                                          smallboxRed('Text'),
                                        ]), //2
                                        Column(
                                          children: [
                                            smallboxRed(currentMatch.minRate
                                                .toString()),
                                          ],
                                        ), //3
                                        Column(
                                          children: [
                                            smallboxRed(currentMatch.maxRate
                                                .toString()),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        //1
                                        Column(children: [
                                          smallboxRed('SMIN/SMAX'),
                                        ]), //2
                                        Column(
                                          children: [
                                            smallboxRed(
                                                currentMatch.sMin.toString()),
                                          ],
                                        ), //3
                                        Column(
                                          children: [
                                            smallboxRed(
                                                currentMatch.sMax.toString()),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                )
              // ignore: unrelated_type_equality_checks
              : const Center(child: CustomLoader(),)
        ],
      ),
    );
  }
}
