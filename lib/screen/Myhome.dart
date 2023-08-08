import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:floating/floating.dart';

import 'package:mycricketline/screen/sidebar/sidebar.dart';
import 'package:mycricketline/screen/tab1/MyCricketHome.dart';
import 'package:mycricketline/screen/tab3/LiveFullScreenList.dart';
import 'package:mycricketline/screen/tab4/upcoming.dart';
import 'package:mycricketline/screen/tab5/fenish.dart';
import 'package:provider/provider.dart';
import '../AipProvider/LiveMatch.dart';
import '../AipProvider/ThemeProvider.dart';
import '../utils/Color.dart';

import '../utils/CustomWidget/Externel.dart';
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

    return WillPopWidget(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: CustomColor.cricketAppBackground,
            title: Center(
              child: Container(
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: CustomStylesBorder.borderRadiusfull,
                  image: const DecorationImage(
                    image: AssetImage("images/textlogo.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            actions: [
              Container(margin: EdgeInsets.only(right: 30), child: Text(""))
            ],
            leading: _isDrawerOpen == false
                ? const Icon(
                    null,
                    color: Colors.transparent,
                  )
                : IconButton(
                    icon: const Icon(
                      Icons.cancel_outlined,
                      color: CustomColor.cricketGradientColor1,
                    ),
                    onPressed: _toggleDrawer,
                  ),
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
                      indicatorColor: CustomColor.cricketPrimary,
                      isScrollable: true,
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
                  bottom: 10, child: BottomNavi(toggleDrawer: _toggleDrawer)),
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

class DEMO extends StatefulWidget {
  const DEMO({super.key});

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
    final rational = Rational.landscape();
    final screenSize =
        MediaQuery.of(context).size * MediaQuery.of(context).devicePixelRatio;
    final height = screenSize.width ~/ rational.aspectRatio;

    final status = await floating.enable(
      aspectRatio: rational,
      sourceRectHint: Rectangle<int>(
        0,
        (screenSize.height ~/ 2) - (height ~/ 2),
        screenSize.width.toInt(),
        height,
      ),
    );
    debugPrint('PiP enabled? $status');
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData.dark(),
        home: PiPSwitcher(
          childWhenDisabled: Scaffold(
            body: Center(child: Image.asset('assets/image.jpg')),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FutureBuilder<bool>(
              future: floating.isPipAvailable,
              initialData: false,
              builder: (context, snapshot) => snapshot.data ?? false
                  ? FloatingActionButton.extended(
                      onPressed: () => enablePip(context),
                      label: const Text('Enable PiP'),
                      icon: const Icon(Icons.picture_in_picture),
                    )
                  : const Card(
                      child: Text('PiP unavailable'),
                    ),
            ),
          ),
          childWhenEnabled: Image.asset('assets/image.jpg'),
        ),
      );
}
