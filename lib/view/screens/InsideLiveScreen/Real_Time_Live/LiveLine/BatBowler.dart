import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/style.dart';


import '../../../../../data/model/real_time_model/RealTimeModel.dart';
import '../../../../component/divider/custom_divider.dart';


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

            dataTextStyle: interRegularDefault.copyWith(color: MyColor.getTextColor() ),

            columns: [
              DataColumn(
                  label: SizedBox(
                width: screenWidth * 0.4,
                child: Text(
                  'Batter',
                  style: interSemiBoldSmall.copyWith(color: MyColor.getTextColor() ),
                ),
              )),
              DataColumn(
                  label: Text(
                'R',
                style:  interBoldExtraSmall.copyWith(color: MyColor.getTextColor() ),
              )),
              DataColumn(
                  label: Text(
                'B',
                style:  interBoldExtraSmall.copyWith(color: MyColor.getTextColor() ),
              )),
              DataColumn(
                  label: Text(
                '4s',
                style:  interBoldExtraSmall.copyWith(color: MyColor.getTextColor() ),
              )),
              DataColumn(
                  label: Text(
                '6s',
                style:  interBoldExtraSmall.copyWith(color: MyColor.getTextColor() ),
              )),
              DataColumn(
                  label: Text(
                'S/F',
                style:  interBoldExtraSmall.copyWith(color: MyColor.getTextColor() ),
              )),
            ],
            rows: batsmen1.batsmen!.map(
              (batsmen) {
                return DataRow(
                    color: MaterialStateColor.resolveWith((states) {
                      return batsmen.name.toString().contains("*")
                          ? MyColor.myGolden()
                          : Colors.transparent;
                    }),
                    cells: [
                      DataCell(Text(
                        batsmen.name.toString(),
                        style:  interBoldSmall.copyWith(color: MyColor.getTextColor() ),
                      )),
                      DataCell(Text(
                        batsmen.run.toString(),
                        style:  interBoldSmall.copyWith(color: MyColor.getTextColor() ),
                      )),
                      DataCell(Text(
                        batsmen.ball.toString(),
                        style:  interBoldSmall.copyWith(color: MyColor.getTextColor() ),
                      )),
                      DataCell(Text(
                        batsmen.fours.toString(),
                        style:  interBoldSmall.copyWith(color: MyColor.getTextColor() ),
                      )),
                      DataCell(Text(
                        batsmen.sixes.toString(),
                        style:  interBoldSmall.copyWith(color: MyColor.getTextColor() ),
                      )),
                      DataCell(Text(
                        batsmen.strikeRate.toString(),
                        style:  interBoldSmall.copyWith(color: MyColor.getTextColor() ),
                      )),
                    ]);
              },
            ).toList(),
          ),
        ),
        const CustomDivider(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            showCheckboxColumn: false,
            horizontalMargin: 5, // Adjust the horizontal margin as needed
            columnSpacing: 5, // Adjust the spacing between columns as needed
            columns: [
              DataColumn(
                  label: SizedBox(
                      width: screenWidth * 0.5,
                      child: Text('Bolwer',
                          style:  interBoldExtraSmall.copyWith(color: MyColor.getTextColor() )))),
              DataColumn(
                  label: Text('M', style:  interBoldExtraSmall.copyWith(color: MyColor.getTextColor() ))),
              DataColumn(
                  label: Text('R', style:  interBoldExtraSmall.copyWith(color: MyColor.getTextColor() ))),
              DataColumn(
                  label: Text('W', style:  interBoldExtraSmall.copyWith(color: MyColor.getTextColor() ))),
              DataColumn(
                  label: Text('O', style:  interBoldExtraSmall.copyWith(color: MyColor.getTextColor() ))),
              DataColumn(
                  label: Text('Eco', style:  interBoldExtraSmall.copyWith(color: MyColor.getTextColor() ))),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text(bowlers.bowler!.name.toString(),
                    style:  interBoldSmall.copyWith(color: MyColor.getTextColor() ))),
                DataCell(Text(bowlers.bowler!.economy.toString(),
                    style:  interBoldSmall.copyWith(color: MyColor.getTextColor() ))),
                DataCell(Text(bowlers.bowler!.wicket.toString(),
                    style:  interBoldSmall.copyWith(color: MyColor.getTextColor() ))),
                DataCell(Text(bowlers.bowler!.run.toString(),
                    style:  interBoldSmall.copyWith(color: MyColor.getTextColor() ))),
                DataCell(Text(bowlers.bowler!.maidens.toString(),
                    style:  interBoldSmall.copyWith(color: MyColor.getTextColor() ))),
                DataCell(Text(bowlers.bowler!.over.toString(),
                    style:  interBoldSmall.copyWith(color: MyColor.getTextColor() ))),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}
