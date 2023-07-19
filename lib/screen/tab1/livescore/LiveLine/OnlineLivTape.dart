import 'package:flutter/material.dart';

import 'package:mycricketline/screen/tab1/livescore/LiveLine/RealTimeLive.dart';
import 'package:provider/provider.dart';

import '../../../../AipProvider/LiveMatch.dart';
import '../../../../utils/Color.dart';
import '../../../../utils/Style.dart';
import '../../../short/shortReel.dart';
import '../Infotab/infotab.dart';
import '../Pip/pip.dart';
import '../commentary/commentary.dart';
import '../odds/odds.dart';
import '../pointTable/pointTable.dart';
import '../scoreboard/scoreboader.dart';

class OnlinelineLiveTabTab extends StatefulWidget {
  var idMatch;
  var type;
  var data;

  OnlinelineLiveTabTab({
    super.key,
    required this.idMatch,
    this.type,
    this.data,
  });

  @override
  State<OnlinelineLiveTabTab> createState() => _OnlinelineLiveTabTabState();
}

class _OnlinelineLiveTabTabState extends State<OnlinelineLiveTabTab>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 7,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var Infoprovider = Provider.of<InfoProvider>(context);
    Infoprovider.fetchLiveMatchesFullDataInfo(widget.idMatch);
    var infoData = Infoprovider.infoMatches;
    var getSiriId;
    getSiriId = infoData.map((e) => e.seriesId);

    return Scaffold(
        backgroundColor: Cricket_app_Background,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Cricket_app_Background,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(0),
              child: TabBar(
                labelPadding: EdgeInsets.all(5),
                controller: _tabController,
                indicatorColor: Cricket_Primary,
                isScrollable: true,
                automaticIndicatorColorAdjustment: true,
                tabs: [
                  Tab(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          border: border,
                          borderRadius: CustomStylesBorder.borderRadius20),
                      child: Text(
                        "Live",
                        style: CustomStyles.smallTextStyle2,
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          border: border,
                          borderRadius: CustomStylesBorder.borderRadius20),
                      child: Text(
                        "Info",
                        style: CustomStyles.smallTextStyle2,
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          border: border,
                          borderRadius: CustomStylesBorder.borderRadius20),
                      child: Text(
                        "Commentary",
                        style: CustomStyles.smallTextStyle2,
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          border: border,
                          borderRadius: CustomStylesBorder.borderRadius20),
                      child: Text(
                        "Scorecard",
                        style: CustomStyles.smallTextStyle2,
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          border: border,
                          borderRadius: CustomStylesBorder.borderRadius20),
                      child: Text(
                        "Odds",
                        style: CustomStyles.smallTextStyle2,
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          border: border,
                          borderRadius: CustomStylesBorder.borderRadius20),
                      child: Text(
                        "PointTable",
                        style: CustomStyles.smallTextStyle2,
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          border: border,
                          borderRadius: CustomStylesBorder.borderRadius20),
                      child: Text(
                        "Pip",
                        style: CustomStyles.smallTextStyle2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              controller: _tabController,
              children: [
                RealTimeLive(
                    idMatch: widget.idMatch,
                    type: widget.type,
                    Data: widget.data),
                Info(
                  id: widget.idMatch,
                  type: widget.type,
                ),
                Commentary(idMatch: widget.idMatch),
                ScoreTable(widget.idMatch),
                Odds(idMatch: widget.idMatch),
                PointTableSreen(
                  idmatch: getSiriId,
                ),
                HomePage()
              ],
            ),
          ],
        ));
  }
}
