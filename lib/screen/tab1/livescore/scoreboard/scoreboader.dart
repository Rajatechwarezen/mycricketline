import 'package:flutter/material.dart';
import 'package:mycricketline/utils/Color.dart';
import 'package:mycricketline/utils/CustomWidget/shimmer.dart';
import 'package:mycricketline/utils/Style.dart';
import 'package:provider/provider.dart';

import '../../../../AipProvider/LiveMatch.dart';
import '../../../../model/scoreModel.dart';

// ignore: must_be_immutable
class ScoreTable extends StatefulWidget {
  var idMatch;

  ScoreTable(this.idMatch, {super.key});

  @override
  State<ScoreTable> createState() => _ScoreTableState();
}

class _ScoreTableState extends State<ScoreTable> {
  final bool _isBatsmanExpanded = true;
  final bool _isBowlerExpanded = true;
  ScoreData? MyListData;

  @override
  Widget build(BuildContext context) {
    var myscore = Provider.of<ScorerProvider>(context);

    myscore.fetchScorecard(widget.idMatch.toString());

    MyListData = myscore.scorerData;

    if (MyListData == null) {
      return summer;
    } else {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //   ExpansionPanelList(
            //     elevation: 0,
            //     expandedHeaderPadding: EdgeInsets.zero,
            //     expansionCallback: (int index, bool isExpanded) {
            //       setState(() {
            //         if (index == 0) {
            //           _isBatsmanExpanded = !isExpanded;
            //         } else if (index == 1) {
            //           _isBowlerExpanded = !isExpanded;
            //         }
            //       });
            //     },
            //     children: [
            //       ExpansionPanel(
            //         headerBuilder: (BuildContext context, bool isExpanded) {
            //           return ListTile(
            //             title: Text(
            //               'Batsman',
            //               style: CustomStyles.cardBoldDarkTextStyle,
            //             ),
            //           );
            //         },
            //         body: SingleChildScrollView(
            //           scrollDirection: Axis.horizontal,
            //           child: DataTable(
            //             headingRowColor: MaterialStateColor.resolveWith(
            //                 (states) => Cricket_Primary!),
            //             dataRowColor: MaterialStateColor.resolveWith(
            //                 (states) => Cricket_ShadowColor!),
            //             columns: [
            //               DataColumn(
            //                 label: SizedBox(
            //                   width: 100,
            //                   child: Text('Batsman',
            //                       style: CustomStyles.cardBoldDarkTextStyleblue),
            //                 ),
            //               ),
            //               DataColumn(
            //                 label:
            //                     Text('Run', style: CustomStyles.cardBoldDarkTextStyleblue),
            //               ),
            //               DataColumn(
            //                 label:
            //                     Text('Ball', style: CustomStyles.cardBoldDarkTextStyleblue),
            //               ),
            //               DataColumn(
            //                 label:
            //                     Text('Fours', style: CustomStyles.cardBoldDarkTextStyleblue),
            //               ),
            //               DataColumn(
            //                 label:
            //                     Text('Sixes', style: CustomStyles.cardBoldDarkTextStyleblue),
            //               ),
            //               DataColumn(
            //                 label: Text('Strike Rate',
            //                     style: CustomStyles.cardBoldDarkTextStyleblue),
            //               ),
            //             ],
            //             rows: MyListData!.data!.team1.batsman.map((batsman) {
            //               return DataRow(
            //                 cells: [
            //                   DataCell(Text(batsman.name ?? "")),
            //                   DataCell(Text(batsman.run.toString())),
            //                   DataCell(Text(batsman.ball.toString())),
            //                   DataCell(Text(batsman.fours.toString())),
            //                   DataCell(Text(batsman.sixes.toString())),
            //                   DataCell(Text(batsman.strikeRate.toString())),
            //                 ],
            //               );
            //             }).toList(),
            //           ),
            //         ),
            //         isExpanded: _isBatsmanExpanded,
            //       ),
            //       ExpansionPanel(
            //         headerBuilder: (BuildContext context, bool isExpanded) {
            //           return ListTile(
            //             title: Text(
            //               'Bowler',
            //               style: CustomStyles.cardBoldDarkDrawerTextStyle,
            //             ),
            //           );
            //         },
            //         body: SingleChildScrollView(
            //           scrollDirection: Axis.horizontal,
            //           child: DataTable(
            //             headingRowColor: MaterialStateColor.resolveWith(
            //                 (states) => Cricket_Primary!),
            //             dataRowColor: MaterialStateColor.resolveWith(
            //                 (states) => Cricket_ShadowColor!),
            //             columns: [
            //               DataColumn(
            //                 label: SizedBox(
            //                   width: 100,
            //                   child: Text('Bowler',
            //                       style: CustomStyles.cardBoldDarkTextStyleblue),
            //                 ),
            //               ),
            //               DataColumn(
            //                 label:
            //                     Text('Run', style: CustomStyles.cardBoldDarkTextStyleblue),
            //               ),
            //               DataColumn(
            //                 label:
            //                     Text('Over', style: CustomStyles.cardBoldDarkTextStyleblue),
            //               ),
            //               DataColumn(
            //                 label: Text('Maiden',
            //                     style: CustomStyles.cardBoldDarkTextStyleblue),
            //               ),
            //               DataColumn(
            //                 label: Text('Wicket',
            //                     style: CustomStyles.cardBoldDarkTextStyleblue),
            //               ),
            //               DataColumn(
            //                 label: Text('Economy',
            //                     style: CustomStyles.cardBoldDarkTextStyleblue),
            //               ),
            //               DataColumn(
            //                 label: Text('Dot Ball',
            //                     style: CustomStyles.cardBoldDarkTextStyleblue),
            //               ),
            //             ],
            //             rows:
            //                 MyListData!.data!.team2.bolwer.map<DataRow>((bowler) {
            //               return DataRow(
            //                 cells: [
            //                   DataCell(Text(bowler.name)),
            //                   DataCell(Text(bowler.run.toString())),
            //                   DataCell(Text(bowler.over.toString())),
            //                   DataCell(Text(bowler.maiden.toString())),
            //                   DataCell(Text(bowler.wicket.toString())),
            //                   DataCell(Text(bowler.economy.toString())),
            //                   DataCell(Text(bowler.dotBall.toString())),
            //                 ],
            //               );
            //             }).toList(),
            //           ),
            //         ),
            //         isExpanded: _isBowlerExpanded,
            //       ),
            //     ],
            //   ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Cricket_white,
                border: border,
                borderRadius: CustomStylesBorder.borderRadius20,
                boxShadow: [boxshadow],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          color: Cricket_white,
                          child: Column(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                margin: const EdgeInsets.only(
                                    top: 5, left: 10, right: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      CustomStylesBorder.borderRadiusfull,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        MyListData!.data!.team1.team.flag),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Text(MyListData!.data!.team1.team.name),
                            ],
                          ),
                        ),
                        Center(
                          child: Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.only(
                                top: 5, left: 10, right: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/vs2.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                margin: const EdgeInsets.only(
                                    top: 5, left: 10, right: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      CustomStylesBorder.borderRadiusfull,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        MyListData!.data!.team2.team.flag),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              sizeboxSmallh,
                              Text(MyListData!.data!.team2.team.name),
                            ],
                          ),
                        ),
                        sizeboxSmallh,
                      ]),
                  Text(
                    MyListData!.result ?? "",
                    style: const TextStyle(
                      color: Cricket_BlackColor3,
                    ),
                  ),
                ],
              ),
            ),

            MyListData!.data!.team1 != null
                ? allTeam(
                    isBatsmanExpanded: _isBatsmanExpanded,
                    isBowlerExpanded: _isBowlerExpanded,
                    MyListData: MyListData!.data!.team1.batsman,
                    MyListDataBol: MyListData!.data!.team1.bolwer,
                    innig: "1")
                : const Text(""),

            MyListData!.data!.team2 != null
                ? allTeam(
                    isBatsmanExpanded: _isBatsmanExpanded,
                    isBowlerExpanded: _isBowlerExpanded,
                    MyListData: MyListData!.data!.team2.batsman,
                    MyListDataBol: MyListData!.data!.team2.bolwer,
                    innig: "2")
                : const Text(""),

            // ignore: unrelated_type_equality_checks
            MyListData!.data!.team1 == ""
                ? allTeam(
                    isBatsmanExpanded: _isBatsmanExpanded,
                    isBowlerExpanded: _isBowlerExpanded,
                    MyListData: MyListData!.data!.team3.batsman,
                    MyListDataBol: MyListData!.data!.team3.bolwer,
                    innig: "1")
                : const Text(""),
            MyListData!.data!.team1 == ""
                ? allTeam(
                    isBatsmanExpanded: _isBatsmanExpanded,
                    isBowlerExpanded: _isBowlerExpanded,
                    MyListData: MyListData!.data!.team4.batsman,
                    MyListDataBol: MyListData!.data!.team4.bolwer,
                    innig: "1")
                : const Text(""),
          ],
        ),
      );
    }
  }
}

allTeam(
    {required bool isBatsmanExpanded,
    required bool isBowlerExpanded,
    required List<BatsmanData>? MyListData,
    required List<BowlerData>? MyListDataBol,
    required String innig}) {
  return ExpansionPanelList(
    elevation: 0,
    expandedHeaderPadding: EdgeInsets.zero,
    expansionCallback: (int index, bool isExpanded) {
      if (index == 0) {
        isBatsmanExpanded = !isExpanded;
      } else if (index == 1) {
        isBowlerExpanded = !isExpanded;
      }
    },
    children: [
      ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return ListTile(
            title: Text(
              'Inning - $innig  ',
              style: CustomStyles.cardBoldDarkTextStyle,
            ),
          );
        },
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DataTable(
                horizontalMargin: 10, // Adjust the horizontal margin as needed
                columnSpacing:
                    13, // Adjust the spacing between columns as needed

                headingRowColor:
                    MaterialStateColor.resolveWith((states) => Cricket_white),
                dataRowColor:
                    MaterialStateColor.resolveWith((states) => Cricket_white),
                columns: [
                  DataColumn(
                    label: SizedBox(
                      width: 130,
                      child: Text('Batman',
                          style: CustomStyles.cardBoldDarkTextStyleblue),
                    ),
                  ),
                  DataColumn(
                    label: Text('R',
                        style: CustomStyles.cardBoldDarkTextStyleblue),
                  ),
                  DataColumn(
                    label: Text('B',
                        style: CustomStyles.cardBoldDarkTextStyleblue),
                  ),
                  DataColumn(
                    label: Text('4s',
                        style: CustomStyles.cardBoldDarkTextStyleblue),
                  ),
                  DataColumn(
                    label: Text('6s',
                        style: CustomStyles.cardBoldDarkTextStyleblue),
                  ),
                  DataColumn(
                    label: Text('SR',
                        style: CustomStyles.cardBoldDarkTextStyleblue),
                  ),
                ],
                rows: MyListData!.map((batsman) {
                  return DataRow(
                    cells: [
                      DataCell(Text(batsman.name ?? "")),
                      DataCell(Text(batsman.run.toString())),
                      DataCell(Text(batsman.ball.toString())),
                      DataCell(Text(batsman.fours.toString())),
                      DataCell(Text(batsman.sixes.toString())),
                      DataCell(Text(batsman.strikeRate.toString())),
                    ],
                  );
                }).toList(),
              ),
              DataTable(
                horizontalMargin: 10, // Adjust the horizontal margin as needed
                columnSpacing:
                    13, // Adjust the spacing between columns as needed

                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Cricket_app_Background!),
                dataRowColor: MaterialStateColor.resolveWith(
                    (states) => Cricket_app_Background!),
                columns: [
                  DataColumn(
                    label: SizedBox(
                      width: 130,
                      child: Text('Bowler',
                          style: CustomStyles.cardBoldDarkTextStyleblue),
                    ),
                  ),
                  DataColumn(
                    label: Text('R',
                        style: CustomStyles.cardBoldDarkTextStyleblue),
                  ),
                  DataColumn(
                    label: Text('O',
                        style: CustomStyles.cardBoldDarkTextStyleblue),
                  ),
                  DataColumn(
                    label: Text('M',
                        style: CustomStyles.cardBoldDarkTextStyleblue),
                  ),
                  DataColumn(
                    label: Text('W',
                        style: CustomStyles.cardBoldDarkTextStyleblue),
                  ),
                  DataColumn(
                    label: Text('Eco',
                        style: CustomStyles.cardBoldDarkTextStyleblue),
                  ),
                  DataColumn(
                    label: Text('DB',
                        style: CustomStyles.cardBoldDarkTextStyleblue),
                  ),
                ],
                rows: MyListDataBol!.map((bowler) {
                  return DataRow(
                    cells: [
                      DataCell(Text(bowler.name)),
                      DataCell(Text(bowler.run.toString())),
                      DataCell(Text(bowler.over.toString())),
                      DataCell(Text(bowler.maiden.toString())),
                      DataCell(Text(bowler.wicket.toString())),
                      DataCell(Text(bowler.economy.toString())),
                      DataCell(Text(bowler.dotBall.toString())),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        isExpanded: isBatsmanExpanded,
      ),
    ],
  );
}
