import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprotbuzz/core/utilis/borderbox.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/style.dart';
import 'package:sprotbuzz/view/component/custom_loader/custom_loader.dart';
import '../../../../data/controller/pointTable_controller/poitntTable_controller.dart';
import '../../../../data/repo/PointTable_repo/PointTableRepo.dart';

class PointTableSreen extends StatefulWidget {
  final idmatch;

  const PointTableSreen({super.key, required this.idmatch});

  @override
  State<PointTableSreen> createState() => _PointTableSreenState();
}

class _PointTableSreenState extends State<PointTableSreen> {
  final PointTableContrller allmatchesController = Get.put(PointTableContrller(
      rointTableRepo: PointTableRepo(apiClient: Get.find())));

  @override
  void initState() {
    super.initState();
    allmatchesController.pointTableData(id: widget.idmatch.toString());
  }

  @override
  Widget build(BuildContext context) {

    return allmatchesController.isLoading.value  ? const CustomLoader():  Container(
      height: 300,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      child: ListView(
        children: [
          _buildHeaderRow(context),
          ...allmatchesController.pointTables.map((teamData) {
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
                        borderRadius: boRadiusAll,
                        image: DecorationImage(
                          image: NetworkImage("$img"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    _buildTableLeftText(
                        context, teams),
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
     
      padding: const EdgeInsets.all(5.0),
      child: Text(text,
          style: interLightSmall.copyWith(color: MyColor.getTextColor())),
    );
  }

  Widget _buildTableCellHeading(BuildContext context, String text,
      {bool isHeader = false}) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: MyColor.getCardBg(),
      ),
      padding: const EdgeInsets.all(5.0),
      child: Text(text.toString(),
          style: interBoldDefault.copyWith(color: MyColor.getTextColor())),
    );
  }

  Widget _buildTableLeftText(BuildContext context, String text,
      {bool isHeader = false}) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: MyColor.getCardBg()),
      padding: const EdgeInsets.all(5.0),
      child: Text(text.toString(),
          style: interBoldDefault.copyWith(color: MyColor.getTextColor())),
    );
  }
}
