import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/data/model/home_page_models.dart';
import 'package:sprotbuzz/view/component/appbar/custom_appbar.dart';
import 'package:sprotbuzz/view/screens/InsideLiveScreen/Commentery/commentery.dart';
import 'package:sprotbuzz/view/screens/InsideLiveScreen/Real_Time_Live/RealTimeLiveScreen.dart';
import 'package:sprotbuzz/view/screens/InsideLiveScreen/ScoreCard/ScoreCard.dart';
import 'package:sprotbuzz/view/screens/InsideLiveScreen/oddTable/oddTable.dart';

import '../../../core/utilis/my_strings.dart';
import '../../../core/utilis/style.dart';
import '../../component/Tabs/tabs_Custom.dart';
import 'Live_Infomation/Live_Info.dart';
import 'pointTable/potntTable.dart';

class InsideLiveScreenTab extends StatefulWidget {
  var idMatch;
  var type;
  // var data;
var allData;
  InsideLiveScreenTab(
      {super.key,
      required this.idMatch,
      this.type,
      // this.data,
      required this.allData});

  @override
  State<InsideLiveScreenTab> createState() => _InsideLiveScreenTabState();
}

class _InsideLiveScreenTabState extends State<InsideLiveScreenTab>
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
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: widget.type,
        ),
        body: DefaultTabController(
          length: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                labelColor: MyColor.getPrimaryTextColor(),
                indicatorColor: MyColor.mycardBorderColor,
                isScrollable: true,
                controller: _tabController,
                dividerColor: MyColor.mytransparentColor,
                tabs: [
                  MyTab(MyStrings.live),
                  MyTab(MyStrings.liveinfo),
                  MyTab(MyStrings.livecom),
                  MyTab(MyStrings.livescard),
                    MyTab(MyStrings.tfrodds),
              
                  MyTab(MyStrings.liveptable),
                  
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: const ScrollPhysics(),
                  controller: _tabController,
                  children: [
                    RealTimeLiveScreen(
                      idMatch: widget.idMatch,
                      allData: widget.allData,
                      type: widget.type,
                    ),
                    Info(
                      id: widget.idMatch,
                      type: widget.type,
                    ),
                    Commentary(idMatch: widget.idMatch),
                    ScoreTable(idMatch: widget.idMatch),
                   OddTableSreen(idmatch: widget.idMatch),
                 
                    PointTableSreen(idmatch: widget.idMatch),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
