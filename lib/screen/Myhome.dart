import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mycricketline/screen/sidebar/sidebar.dart';
import 'package:mycricketline/screen/tab1/MyCricketHome.dart';
import 'package:mycricketline/screen/tab3/LiveFullScreenList.dart';
import 'package:mycricketline/screen/tab4/upcoming.dart';
import 'package:mycricketline/screen/tab5/fenish.dart';
import 'package:provider/provider.dart';
import '../AipProvider/LiveMatch.dart';
import '../AipProvider/ThemeProvider.dart';
import '../utils/Color.dart';

import '../utils/CustomWidget/willpop.dart';
import '../utils/Style.dart';
import 'bottomnavigation/bottomNavi.dart';

class CricketPage extends StatefulWidget {
  const CricketPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CricketPageState createState() => _CricketPageState();
}

class _CricketPageState extends State<CricketPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  bool _isDrawerOpen = false;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _tabController = TabController(
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _tabController.dispose();
    //////////////////////
  }

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
    if (_isDrawerOpen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final liveMatchProvider = Provider.of<LiveMatchProvider>(context);
    final seriesdata = Provider.of<SeriesProvider>(context);
    final newsProvider = Provider.of<LiveMatchProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return WillPopWidget(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Cricket_app_Background,
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Cricket_app_Background,
            title: Center(
              child: Container(
                height: 25,
                margin: const EdgeInsets.only(left: 40),
                decoration: BoxDecoration(
                  borderRadius: CustomStylesBorder.borderRadiusfull,
                  image: const DecorationImage(
                    image: AssetImage("images/textlogo.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            // leading: IconButton(
            //   icon: Icon(
            //     _isDrawerOpen == false
            //         ? Icons.label_important
            //         : Icons.cancel_outlined,
            //     color: Cricket_Gradient_color1,
            //   ),
            //   onPressed: _toggleDrawer,
            // ),
            actions: [
              Switch(
                value: themeProvider.isDarkTheme,
                onChanged: (_) => themeProvider.toggleTheme(),
              ),
              sizeboxSmallw,
            ],
          ),
          body: Stack(
            children: [
              Positioned(
                top: 20,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.zero,
                    child: TabBar(
                      labelPadding: const EdgeInsets.all(5),
                      controller: _tabController,
                      indicatorColor: Cricket_Primary,
                      isScrollable: true,
                      automaticIndicatorColorAdjustment: true,
                      tabs: [
                        Tab(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              border: border,
                              borderRadius: CustomStylesBorder.borderRadius20,
                            ),
                            child: Text(
                              "All",
                              style: CustomStyles.smallTextStyle2,
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              border: border,
                              borderRadius: CustomStylesBorder.borderRadius20,
                            ),
                            child: Text(
                              "Live",
                              style: CustomStyles.smallTextStyle2,
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              border: border,
                              borderRadius: CustomStylesBorder.borderRadius20,
                            ),
                            child: Text(
                              "Upcoming",
                              style: CustomStyles.smallTextStyle2,
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              border: border,
                              borderRadius: CustomStylesBorder.borderRadius20,
                            ),
                            child: Text(
                              "Finished",
                              style: CustomStyles.smallTextStyle2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: kToolbarHeight * 1.2,
                bottom: 0,
                left: 0,
                right: 0,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    RefreshIndicator(
                      onRefresh: () async {
                        await newsProvider.fetchNewsList();
                        await liveMatchProvider.fetchLiveMatches();
                        await seriesdata.fetchSeriesData();
                      },
                      child: Container(
                        alignment: Alignment.topCenter,
                        margin: const EdgeInsets.only(top: 20),
                        child: const CricketCard(),
                      ),
                    ),
                    LiveFullDemo(lengthType: ""),
                    Upcomings(lengthType: ""),
                    FinishMatch(lengthType: ""),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                right: -5,
                child: BottomNavi(),
              ),
              sizeboxSmallh,
              sizeboxSmallh,
              CustomNavigationDrawer(isDrawerOpen: _isDrawerOpen),
            ],
          ),
        ),
      ),
    );
  }
}
