import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mycricketline/utils/Color.dart';
import 'package:provider/provider.dart';

import '../../../../AipProvider/oddsApi.dart';
import '../../../../model/OddsData.dart';
import '../../../../utils/CustomWidget/Externel.dart';
import '../../../../utils/CustomWidget/shimmer.dart';
import '../../../../utils/Style.dart';

class Odds extends StatefulWidget {
  var idMatch;
  Odds({
    super.key,
    required this.idMatch,
  });
  @override
  _OddsState createState() => _OddsState();
}

class _OddsState extends State<Odds> {
  bool _isFirstInning = true;

  void _toggleInning() {
    setState(() {
      _isFirstInning = !_isFirstInning;
    });
  }

  @override
  Widget build(BuildContext context) {
    var cricketMatchOdds = Provider.of<OddsApiProvider>(context);

    cricketMatchOdds.matchOdds(idMatch: widget.idMatch);
    List<CricketMatchOdds>? _currentMatch = cricketMatchOdds.cricketMatchOdds;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: _toggleInning,
            child: customboxbutton2(
                _isFirstInning ? 'Second Inning' : 'First Inning'),
          ),
          SizedBox(height: 16),
          _currentMatch != null
              ? Column(
                  children: _currentMatch.map((currentMatch) {
                    return Container(
                      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                      padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                      decoration: BoxDecoration(
                        color: Cricket_white,
                        border: border,
                        borderRadius: CustomStylesBorder.boderRadius10,
                        boxShadow: [boxshadow],
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
                                              color: Cricket_BlackColor3,
                                              borderRadius: CustomStylesBorder
                                                  .borderRadiusfull),
                                          child: Text(
                                            currentMatch.runs.toString(),
                                            style: CustomStyles
                                                .cardNormalTextStyle,
                                          )),
                                      sizeboxSmallh,
                                      Text(
                                        currentMatch.time.toString(),
                                        style:
                                            CustomStyles.cardBoldDarkTextStyle2,
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
                                      sizeboxSmallh,
                                      Text(
                                        currentMatch.overs.toString(),
                                        style: CustomStyles
                                            .cardBoldDarkTextStyleGreen,
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
                              borderRadius: CustomStylesBorder.boderRadius10,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Team: ${currentMatch.team.toString()}',
                                  style: CustomStyles.cardBoldDarkTextStyle2,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        //1
                                        Column(children: [
                                          smallboxRedScore2('Text'),
                                        ]), //2
                                        Column(
                                          children: [
                                            smallboxblue(currentMatch.minRate
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
                                          smallboxRedScore2('SMIN/SMAX'),
                                        ]), //2
                                        Column(
                                          children: [
                                            smallboxblue(
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
              : summer,
        ],
      ),
    );
  }
}
