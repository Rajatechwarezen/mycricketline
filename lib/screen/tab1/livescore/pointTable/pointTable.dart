import 'package:flutter/material.dart';
import 'package:mycricketline/AipProvider/pointTableApi.dart';
import 'package:mycricketline/utils/Color.dart';
import 'package:mycricketline/utils/Style.dart';
import 'package:provider/provider.dart';

import '../../../../AipProvider/LiveMatch.dart';
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
    var myYourDataProvider = Provider.of<YourDataProvider>(context);
    myYourDataProvider.fetchPointTable(widget.idmatch);
    var teamDataList = myYourDataProvider.pointTables;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1.0),
      ),
      child: Container(
        color: Cricket_white,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(border: border, boxShadow: [boxshadow]),
        child: Table(
          defaultColumnWidth: const FlexColumnWidth(1.0),
          border: TableBorder.symmetric(
            inside: BorderSide(
              color: Colors.grey.withOpacity(0.5),
              width: 1.0,
            ),
          ),
          children: [
            _buildTableRow(
              context,
              'Teams',
              'P',
              'W',
              'L',
              'NR',
              'Pts',
              'NRR',
            ),
            ...teamDataList.map((teamData) {
              return _buildTableRow(
                context,
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
      ),
    );
  }

  TableRow _buildTableRow(
    BuildContext context,
    String teams,
    String p,
    String w,
    String l,
    String nr,
    String pts,
    String nrr,
  ) {
    return TableRow(
      children: [
        _buildTableCell(context, teams),
        _buildTableCell(context, p),
        _buildTableCell(context, w),
        _buildTableCell(context, l),
        _buildTableCell(context, nr),
        _buildTableCell(context, pts),
        _buildTableCell(context, nrr),
      ],
    );
  }

  TableCell _buildTableCell(BuildContext context, String text) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(1.0),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
