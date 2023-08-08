import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycricketline/model/Livematch.dart';
import 'package:mycricketline/utils/Style.dart';

import '../../../../utils/Color.dart';

class MatchDetailsLayout extends StatelessWidget {
  LiveMatchFull batsmen1;
  LiveMatchFull batsmen2;
  LiveMatchFull bowlers;
  MatchDetailsLayout({
    super.key,
    required this.batsmen1,
    required this.batsmen2,
    required this.bowlers,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            horizontalMargin: 10, // Adjust the horizontal margin as needed
            columnSpacing: 13, // Adjust the spacing between columns as needed

            dataTextStyle: CustomStyles.cardBoldDarkDrawerTextStyle,

            columns: [
              DataColumn(
                  label: SizedBox(
                width: screenWidth * 0.4,
                child: Text(
                  'Batter',
                  style: CustomStyles.smallLightTextStyle2,
                ),
              )),
              DataColumn(
                  label: Text(
                'R',
                style: CustomStyles.smallLightTextStyle2,
              )),
              DataColumn(
                  label: Text(
                'B',
                style: CustomStyles.smallLightTextStyle2,
              )),
              DataColumn(
                  label: Text(
                '4s',
                style: CustomStyles.smallLightTextStyle2,
              )),
              DataColumn(
                  label: Text(
                '6s',
                style: CustomStyles.smallLightTextStyle2,
              )),
              DataColumn(
                  label: Text(
                'S/F',
                style: CustomStyles.smallLightTextStyle2,
              )),
            ],
            rows: batsmen1.batsmen!.map(
              (batsmen) {
                return DataRow(
                    color: MaterialStateColor.resolveWith((states) {
                      return batsmen.name.toString().contains("*")
                          ? CustomColor.cricketDarkPrimary
                          : Colors.transparent;
                    }),
                    cells: [
                      DataCell(Text(
                        batsmen.name.toString(),
                        style: CustomStyles.cardBoldDarkTextStyleblue,
                      )),
                      DataCell(Text(
                        batsmen.run.toString(),
                        style: CustomStyles.cardBoldDarkTextStyle2,
                      )),
                      DataCell(Text(
                        batsmen.ball.toString(),
                        style: CustomStyles.cardBoldDarkTextStyle2,
                      )),
                      DataCell(Text(
                        batsmen.fours.toString(),
                        style: CustomStyles.cardBoldDarkTextStyle2,
                      )),
                      DataCell(Text(
                        batsmen.sixes.toString(),
                        style: CustomStyles.cardBoldDarkTextStyle2,
                      )),
                      DataCell(Text(
                        batsmen.strikeRate.toString(),
                        style: CustomStyles.cardBoldDarkTextStyle2,
                      )),
                    ]);
              },
            ).toList(),
          ),
        ),
        const Divider(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            showCheckboxColumn: false,
            horizontalMargin: 10, // Adjust the horizontal margin as needed
            columnSpacing: 13, // Adjust the spacing between columns as needed
            columns: [
              DataColumn(
                  label: SizedBox(
                      width: screenWidth * 0.4,
                      child: Text('Bolwer',
                          style: CustomStyles.smallLightTextStyle2))),
              DataColumn(
                  label: Text('M', style: CustomStyles.smallLightTextStyle2)),
              DataColumn(
                  label: Text('R', style: CustomStyles.smallLightTextStyle2)),
              DataColumn(
                  label: Text('W', style: CustomStyles.smallLightTextStyle2)),
              DataColumn(
                  label: Text('O', style: CustomStyles.smallLightTextStyle2)),
              DataColumn(
                  label: Text('Eco', style: CustomStyles.smallLightTextStyle2)),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text(bowlers.bowler!.name.toString(),
                    style: CustomStyles.cardBoldDarkTextStyleblue)),
                DataCell(Text(bowlers.bowler!.economy.toString(),
                    style: CustomStyles.cardBoldDarkTextStyle2)),
                DataCell(Text(bowlers.bowler!.wicket.toString(),
                    style: CustomStyles.cardBoldDarkTextStyle2)),
                DataCell(Text(bowlers.bowler!.run.toString(),
                    style: CustomStyles.cardBoldDarkTextStyle2)),
                DataCell(Text(bowlers.bowler!.maidens.toString(),
                    style: CustomStyles.cardBoldDarkTextStyle2)),
                DataCell(Text(bowlers.bowler!.over.toString(),
                    style: CustomStyles.cardBoldDarkTextStyle2)),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}
