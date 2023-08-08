import 'package:flutter/material.dart';
import 'package:mycricketline/screen/tab1/trending/upcomingByTrending.dart';

import '../../../utils/Color.dart';
import '../../../utils/Style.dart';
import 'finishByTrending.dart';

class TrendingView extends StatefulWidget {
  var matchid;
  var trendingViewName;
  TrendingView(
      {super.key, required this.matchid, required this.trendingViewName});

  @override
  State<TrendingView> createState() => _TrendingViewState();
}

class _TrendingViewState extends State<TrendingView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
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
    return Scaffold(
        backgroundColor: CustomColor.cricketAppBackground,
        appBar: AppBar(
          iconTheme: IconThemeData(color: CustomColor.cricketBlackColor),
          title: Center(
              child: Text(
            widget.trendingViewName,
            style: CustomStyles.cardBoldDarkDrawerTextStyle,
          )),
          elevation: 0,
          backgroundColor: CustomColor.cricketAppBackground,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(0),
              child: TabBar(
                labelPadding: const EdgeInsets.all(5),
                controller: _tabController,
                indicatorColor: CustomColor.cricketPrimary,
                isScrollable: true,
                automaticIndicatorColorAdjustment: true,
                tabs: [
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
                        "Upcoming",
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
                        "Finish",
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
                TrendingByupcoming(
                  matchid: widget.matchid,
                ),
                TrendingByfinish(
                  matchid: widget.matchid,
                )
              ],
            ),
          ],
        ));
  }
}
