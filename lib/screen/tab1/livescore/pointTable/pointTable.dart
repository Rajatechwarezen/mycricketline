import 'package:flutter/material.dart';
import 'package:mycricketline/AipProvider/pointTableApi.dart';
import 'package:mycricketline/utils/Color.dart';
import 'package:mycricketline/utils/Style.dart';
import 'package:provider/provider.dart';

import '../../../../AipProvider/LiveMatch.dart';
import '../../../../AipProvider/ThemeProvider.dart';
import '../../../../model/player.dart';
import '../../../../model/pointTableData.dart';

class PointTableSreen extends StatefulWidget {
  final idmatch;

  const PointTableSreen({required this.idmatch});

  @override
  State<PointTableSreen> createState() => _PointTableSreenState();
}

class _PointTableSreenState extends State<PointTableSreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    var myYourDataProvider = Provider.of<YourDataProvider>(context);
    myYourDataProvider.fetchPointTable(widget.idmatch);
    var teamDataList = myYourDataProvider.pointTables;
    return Container(
      height: 300,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      child: ListView(
        children: [
          _buildHeaderRow(context),
          ...teamDataList.map((teamData) {
            return _buildDataRow(
              context,
              teamData.flag,
              teamData.teams,
              teamData.p,
              teamData.w,
              teamData.l,
              teamData.nr,
              teamData.pts,
              teamData.nrr,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: 85,
              child: _buildTableCellHeading(context, 'Teams', isHeader: true)),
          SizedBox(
              width: 40,
              child: _buildTableCellHeading(context, 'P', isHeader: true)),
          SizedBox(
              width: 40,
              child: _buildTableCellHeading(context, 'W', isHeader: true)),
          SizedBox(
              width: 40,
              child: _buildTableCellHeading(context, 'L', isHeader: true)),
          SizedBox(
              width: 40,
              child: _buildTableCellHeading(context, 'NR', isHeader: true)),
          SizedBox(
              width: 40,
              child: _buildTableCellHeading(context, 'Pts', isHeader: true)),
          SizedBox(
              width: 60,
              child: _buildTableCellHeading(context, 'NRR', isHeader: true)),
        ],
      ),
    );
  }

  Widget _buildDataRow(
    BuildContext context,
    String img,
    String teams,
    String p,
    String w,
    String l,
    String nr,
    String pts,
    String nrr,
  ) {
    var firstLetterTeam = teams.split(" ")[0].split("")[0];
    var secondLetterTeam = teams.split(" ")[1];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
                width: 85,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: CustomStylesBorder.borderRadiusfull,
                        image: DecorationImage(
                          image: NetworkImage("$img"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    _buildTableLeftText(
                        context, "$firstLetterTeam $secondLetterTeam"),
                  ],
                )),
            SizedBox(width: 40, child: _buildTableCell(context, p)),
            SizedBox(width: 40, child: _buildTableCell(context, w)),
            SizedBox(width: 40, child: _buildTableCell(context, l)),
            SizedBox(width: 40, child: _buildTableCell(context, nr)),
            SizedBox(width: 40, child: _buildTableCell(context, pts)),
            SizedBox(width: 60, child: _buildTableCell(context, nrr)),
          ],
        ),
      ),
    );
  }

  Widget _buildTableCell(BuildContext context, String text,
      {bool isHeader = false}) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: CustomStylesBorder.boderRadius10,
        border: border,
        color: CustomColor.cricketTextColorPrimary,
      ),
      padding: const EdgeInsets.all(5.0),
      child: Text(text, style: CustomStyles.smallLightTextStyle2),
    );
  }

  Widget _buildTableCellHeading(BuildContext context, String text,
      {bool isHeader = false}) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: CustomColor.cricketDarkBlackColor3,
      ),
      padding: const EdgeInsets.all(5.0),
      child: Text(text, style: CustomStyles.smallLightTextStylebold),
    );
  }

  Widget _buildTableLeftText(BuildContext context, String text,
      {bool isHeader = false}) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: CustomColor.cricketTextColorPrimary, border: border),
      padding: const EdgeInsets.all(5.0),
      child: Text(text, style: CustomStyles.smallLightTextStyle2),
    );
  }
}
