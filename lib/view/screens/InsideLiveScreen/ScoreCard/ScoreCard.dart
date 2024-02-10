import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sprotbuzz/core/utilis/boxSpace.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/style.dart';
import 'package:sprotbuzz/data/repo/scoreTabl_repo/scoretable_repo.dart';
import 'package:sprotbuzz/view/component/custom_loader/custom_loader.dart';
import '../../../../core/utilis/borderbox.dart';
import '../../../../data/controller/ScoreTable_Controller/ScoreTable_controller.dart';
import '../../../../data/model/scoreTable_model/scoreTable_model.dart';

// ignore: must_be_immutable
class ScoreTable extends StatefulWidget {
  var idMatch;

  ScoreTable({
    super.key,
    this.idMatch,
  });

  @override
  State<ScoreTable> createState() => _ScoreTableState();
}

class _ScoreTableState extends State<ScoreTable> {
  final bool _isBatsmanExpanded = true;
  final bool _isBowlerExpanded = true;


  final ScoreTableController allmatchesController = Get.put(
      ScoreTableController(
          scoreTableRepo: ScoreTableRepo(apiClient: Get.find())));

  @override
  void initState() {
    super.initState();
    allmatchesController.fetchScorecard(id: widget.idMatch.toString());
  }

  @override
  Widget build(BuildContext context) {
//////////////////////////

    return SingleChildScrollView(
      child: GetBuilder<ScoreTableController>(builder: (controller) {
        return  allmatchesController!.scoreData !=null ? allmatchesController.isLoading.value
            ? CustomLoader()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: MyColor.getCardBg(),
                        border: border,
                        borderRadius: boRadiusAll,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
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
                              ]),
                          Text(
                            allmatchesController!.scoreData!.result ?? "",
                            style: TextStyle(
                              color: MyColor.getCardBg(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    allmatchesController.scoreData!.data!.team1 != null
                        ? allTeam(
                            isBatsmanExpanded: _isBatsmanExpanded,
                            isBowlerExpanded: _isBowlerExpanded,
                            MyListData: allmatchesController!.scoreData!.data!.team1.batsman,
                            MyListDataBol:
                                allmatchesController!.scoreData!.data!.team1.bolwer,
                            innig: "1")
                        : const Text(""),

                    allmatchesController.scoreData!.data!.team2 != null
                        ? allTeam(
                            isBatsmanExpanded: _isBatsmanExpanded,
                            isBowlerExpanded: _isBowlerExpanded,
                            MyListData: allmatchesController!.scoreData!.data!.team2.batsman,
                            MyListDataBol:
                                allmatchesController!.scoreData!.data!.team2.bolwer,
                            innig: "2")
                        : const Text(""),

                    // ignore: unrelated_type_equality_checks
                    allmatchesController!.scoreData!.data!.team1 == ""
                        ? allTeam(
                            isBatsmanExpanded: _isBatsmanExpanded,
                            isBowlerExpanded: _isBowlerExpanded,
                            MyListData: allmatchesController.scoreData!.data!.team3.batsman,
                            MyListDataBol:
                                allmatchesController.scoreData!.data!.team3.bolwer,
                            innig: "1")
                        : const Text(""),
                    allmatchesController!.scoreData!.data!.team1 == ""
                        ? allTeam(
                            isBatsmanExpanded: _isBatsmanExpanded,
                            isBowlerExpanded: _isBowlerExpanded,
                            MyListData: allmatchesController.scoreData!.data!.team4.batsman,
                            MyListDataBol:
                                allmatchesController.scoreData!.data!.team4.bolwer,
                            innig: "1")
                        : const Text(""),
                  ],
                ),
              ):  CustomLoader();
      }),
    );
  }
}

allTeam(
    {required bool isBatsmanExpanded,
    required bool isBowlerExpanded,
    required List<BatsmanData>? MyListData,
    required List<BowlerData>? MyListDataBol,
    required String innig}) {
  return ExpansionPanelList(
    dividerColor: MyColor.myshimmerBaseColor,
    expandIconColor: MyColor.getTextColor(),
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
              style: interBoldDefault.copyWith(color: MyColor.getTextColor()),
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
                    (states) => MyColor.getCardBg()),
                dataRowColor: MaterialStateColor.resolveWith(
                    (states) => MyColor.getCardBg()),
                columns: [
                  DataColumn(
                    label: SizedBox(
                      width: 130,
                      child: Text('Batman',
                          style: interBoldDefault.copyWith(
                              color: MyColor.myGolden())),
                    ),
                  ),
                  DataColumn(
                    label: Text('R',
                        style: interBoldDefault.copyWith(
                            color: MyColor.myGolden())),
                  ),
                  DataColumn(
                    label: Text('B',
                        style: interBoldDefault.copyWith(
                            color: MyColor.myGolden())),
                  ),
                  DataColumn(
                    label: Text('4s',
                        style: interBoldDefault.copyWith(
                            color: MyColor.myGolden())),
                  ),
                  DataColumn(
                    label: Text('6s',
                        style: interBoldDefault.copyWith(
                            color: MyColor.myGolden())),
                  ),
                  DataColumn(
                    label: Text('SR',
                        style: interBoldDefault.copyWith(
                            color: MyColor.myGolden())),
                  ),
                ],
                rows: MyListData!.map((batsman) {
                  return DataRow(
                    cells: [
                      DataCell(Text(batsman.name ?? "",
                          style: interBoldSmall.copyWith(
                              color: MyColor.getTextColor()))),
                      DataCell(Text(batsman.run.toString(),
                          style: interBoldSmall.copyWith(
                              color: MyColor.getTextColor()))),
                      DataCell(Text(batsman.ball.toString(),
                          style: interBoldSmall.copyWith(
                              color: MyColor.getTextColor()))),
                      DataCell(Text(batsman.fours.toString(),
                          style: interBoldSmall.copyWith(
                              color: MyColor.getTextColor()))),
                      DataCell(Text(batsman.sixes.toString(),
                          style: interBoldSmall.copyWith(
                              color: MyColor.getTextColor()))),
                      DataCell(Text(batsman.strikeRate.toString(),
                          style: interBoldSmall.copyWith(
                              color: MyColor.getTextColor()))),
                    ],
                  );
                }).toList(),
              ),
              DataTable(
                horizontalMargin: 10, // Adjust the horizontal margin as needed
                columnSpacing:
                    13, // Adjust the spacing between columns as needed

                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => MyColor.getCardBg()),
                dataRowColor: MaterialStateColor.resolveWith(
                    (states) => MyColor.getCardBg()),
                columns: [
                  DataColumn(
                    label: SizedBox(
                      width: 130,
                      child: Text('Bowler',
                          style: interBoldDefault.copyWith(
                              color: MyColor.myGolden())),
                    ),
                  ),
                  DataColumn(
                    label: Text('R',
                        style: interBoldDefault.copyWith(
                            color: MyColor.myGolden())),
                  ),
                  DataColumn(
                    label: Text('O',
                        style: interBoldDefault.copyWith(
                            color: MyColor.myGolden())),
                  ),
                  DataColumn(
                    label: Text('M',
                        style: interBoldDefault.copyWith(
                            color: MyColor.myGolden())),
                  ),
                  DataColumn(
                    label: Text('W',
                        style: interBoldDefault.copyWith(
                            color: MyColor.myGolden())),
                  ),
                  DataColumn(
                    label: Text('Eco',
                        style: interBoldDefault.copyWith(
                            color: MyColor.myGolden())),
                  ),
                  DataColumn(
                    label: Text('DB',
                        style: interBoldDefault.copyWith(
                            color: MyColor.myGolden())),
                  ),
                ],
                rows: MyListDataBol!.map((bowler) {
                  return DataRow(
                    color: MaterialStateProperty.resolveWith(
                        (states) => MyColor.getBottomNavBg()),
                    cells: [
                      DataCell(Text(bowler.name,
                          style: interBoldSmall.copyWith(
                              color: MyColor.getTextColor()))),
                      DataCell(Text(bowler.run.toString(),
                          style: interBoldSmall.copyWith(
                              color: MyColor.getTextColor()))),
                      DataCell(Text(bowler.over.toString(),
                          style: interBoldSmall.copyWith(
                              color: MyColor.getTextColor()))),
                      DataCell(Text(bowler.maiden.toString(),
                          style: interBoldSmall.copyWith(
                              color: MyColor.getTextColor()))),
                      DataCell(Text(bowler.wicket.toString(),
                          style: interBoldSmall.copyWith(
                              color: MyColor.getTextColor()))),
                      DataCell(Text(bowler.economy.toString(),
                          style: interBoldSmall.copyWith(
                              color: MyColor.getTextColor()))),
                      DataCell(Text(bowler.dotBall.toString(),
                          style: interBoldSmall.copyWith(
                              color: MyColor.getTextColor()))),
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
