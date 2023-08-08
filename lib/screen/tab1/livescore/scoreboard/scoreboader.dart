import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mycricketline/utils/Color.dart';
import 'package:mycricketline/utils/CustomWidget/shimmer.dart';
import 'package:mycricketline/utils/Style.dart';
import 'package:provider/provider.dart';

import '../../../../AipProvider/LiveMatch.dart';
import '../../../../AipProvider/ThemeProvider.dart';
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

    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    myscore.fetchScorecard(widget.idMatch.toString());

    MyListData = myscore.scorerData;
//////////////////////////
    var Infoprovider = Provider.of<InfoProvider>(context);
    Infoprovider.fetchLiveMatchesFullDataInfo(widget.idMatch);
    var infoData = Infoprovider.infoMatches;
    if (MyListData == null) {
      return MyListData == [] || MyListData == "[]"
          ? summer
          : Center(
              child: Lottie.asset(
                'images/empty.json', // Path to your JSON animation file
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
            );
    } else {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: themeProvider.isDarkTheme
                    ? CustomColor.cricketWhite
                    : CustomColor.cricketBlackColor,
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
                                    image: NetworkImage(infoData[0].teamAImg),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              sizeboxSmallh,
                              Text(infoData[0].teamA),
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
                                    image: NetworkImage(infoData[0].teamBImg),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              sizeboxSmallh,
                              Text(infoData[0].teamB),
                            ],
                          ),
                        ),
                        sizeboxSmallh,
                      ]),
                  Text(
                    MyListData!.result ?? "",
                    style: const TextStyle(
                      color: CustomColor.cricketBlackColor3,
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

                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => CustomColor.cricketWhite),
                dataRowColor: MaterialStateColor.resolveWith(
                    (states) => CustomColor.cricketWhite),
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
                    (states) => CustomColor.cricketAppBackground!),
                dataRowColor: MaterialStateColor.resolveWith(
                    (states) => CustomColor.cricketAppBackground!),
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
