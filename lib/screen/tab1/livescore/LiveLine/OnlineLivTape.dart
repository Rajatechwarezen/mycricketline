import 'package:flutter/material.dart';

import 'package:mycricketline/screen/tab1/livescore/LiveLine/RealTimeLive.dart';
import 'package:provider/provider.dart';

import 'dart:math';

import 'dart:async';

import 'package:floating/floating.dart';

import '../../../../AipProvider/LiveMatch.dart';
import '../../../../utils/Color.dart';
import '../../../../utils/Style.dart';
import '../../../short/shortReel.dart';
import '../Infotab/infotab.dart';

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
      length: 6,
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
        backgroundColor: CustomColor.cricketAppBackground,
        appBar: AppBar(
          iconTheme: IconThemeData(color: CustomColor.cricketBlackColor),
          elevation: 0,
          backgroundColor: CustomColor.cricketAppBackground,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(0),
              child: TabBar(
                labelPadding: EdgeInsets.all(5),
                controller: _tabController,
                indicatorColor: CustomColor.cricketPrimary,
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
                DEMO(
                    idMatch: widget.idMatch,
                    type: widget.type,
                    data: widget.data),
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
              ],
            ),
          ],
        ));
  }
}

class DEMO extends StatefulWidget {
  final int idMatch;
  final String type;
  final dynamic data;
  const DEMO({super.key, required this.idMatch, required this.type, this.data});

  @override
  State<DEMO> createState() => _DEMOState();
}

class _DEMOState extends State<DEMO> with WidgetsBindingObserver {
  final floating = Floating();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    floating.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycleState) {
    if (lifecycleState == AppLifecycleState.inactive) {
      floating.enable(aspectRatio: Rational.square());
    }
  }

  Future<void> enablePip(BuildContext context) async {
    final rational = const Rational.landscape();
    final screenSize =
        MediaQuery.of(context).size * MediaQuery.of(context).devicePixelRatio;
    final height = screenSize.width ~/ rational.aspectRatio;

    final status = await floating.enable(
      aspectRatio: rational,
      sourceRectHint: Rectangle<int>(
        0,
        (screenSize.height ~/ 2) - (height ~/ 3),
        screenSize.width.toInt(),
        height,
      ),
    );
    debugPrint('PiP enabled? $status');
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          // This function will be executed when the user clicks on the back/pop button
          enablePip(context);

          return true; // Set this to false if you want to prevent the pop.
        },
        child: PiPSwitcher(
          childWhenDisabled: RealTimeLive(
              idMatch: widget.idMatch, type: widget.type, Data: widget.data),
          childWhenEnabled: RealTimeLive(
              idMatch: widget.idMatch, type: widget.type, Data: widget.data),
        ),
      );
}
