import 'dart:convert';

import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;

import 'package:sprotbuzz/core/utilis/dimansion.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/my_images.dart';
import 'package:sprotbuzz/core/utilis/my_strings.dart';
import 'package:sprotbuzz/core/utilis/style.dart';

import 'package:sprotbuzz/core/utilis/utilis.dart';
import 'package:sprotbuzz/view/component/Tabs/tabs_Custom.dart';
import 'package:sprotbuzz/view/component/bottom_Nav/bottom_nav.dart';
import 'package:sprotbuzz/view/screens/home/home_screen.dart';
import 'data/controller/theme_controller.dart';
import 'view/component/image/round_shape_icon.dart';
import 'view/component/neternet_connection/internet_checker.dart';
import 'view/component/no_data/no_data_widget.dart';
import 'view/screens/Ads/bannerAds.dart';
import 'view/screens/home/liveMatch/liveMatch.dart';

class CricketHomePage extends StatefulWidget {
  const CricketHomePage({Key? key}) : super(key: key);

  @override
  State<CricketHomePage> createState() => _CricketHomePageState();
}

class _CricketHomePageState extends State<CricketHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  //ads property
  Container adContainer = Container(height: 0);
  Widget _currentAd = SizedBox(width: 0.0, height: 0.0);
  BannerAd? myBanner;

  showFacebookBanner() {
    String bannerFanId = "37b1da9d-b48c-4103-a393-2e095e734bd6";
 
    setState(() {
      _currentAd = FacebookBannerAd(
        placementId: bannerFanId,
        bannerSize: BannerSize.STANDARD,
        listener: (result, value) {
          print("Banner Ad: $result -->  $value");
        },
      );
    });
  }

  showAdmobBanner() {

    myBanner = BannerAd(
      adUnitId: "ca-app-pub-1658074074654406/414499534",
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
          onAdLoaded: (Ad ad) => print('Ad loaded.'),
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            ad.dispose();
            print('Ad failed to load: $error');
          }),
    );
    myBanner?.load();
    AdWidget adWidget = AdWidget(ad: myBanner!);
    setState(() {
      adContainer = Container(
        alignment: Alignment.center,
        width: myBanner!.size.width.toDouble(),
        height: myBanner!.size.height.toDouble(),
        child: adWidget,
      );
    });
  }

  //ads property
  @override
  void initState() {
    super.initState();
    initBannerAds();
//Internet connection
    getConnectivity(context, setState);

    Get.put<ThemeController>(
      ThemeController(sharedPreferences: Get.find()),
    );

    ThemeController themeController = Get.find();
    MyUtils.allScreensUtils(themeController.darkTheme);

    _tabController = TabController(length: 2, vsync: this);

  }

  initBannerAds() {
    showFacebookBanner();

    showAdmobBanner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ShapeIcon(
          icon: MyImages.filter,
          height: 18,
          width: 430,
        ),
        bottom: TabBar(
          labelColor: MyColor.getPrimaryTextColor(),
          indicatorColor: MyColor.getPrimaryTextColor(),
          isScrollable: true,
          labelPadding: EdgeInsets.zero,
          tabAlignment: TabAlignment.start,
          controller: _tabController,
          dividerColor: MyColor.mytransparentColor,
          tabs: [MyTab(MyStrings.hhome), MyTab(MyStrings.hlive.tr)],
        ),
      ),
      body: TabBarView(
        physics: const ScrollPhysics(),
        controller: _tabController,
        children:  [
          //home Screen ---------------------------------------------------------------
          Stack(
            children: [
              HomeScreen(),
                 
              //Ads ---------------------------------------------------------------
               Positioned(
                bottom: 0,
                left: 0,
                child:    BannerAdWidget())
            ],
          ),

          //Live Match Screen ----------------------------------------------------------

          LiveMatchList()
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(
        currentIndex: 0,
      ),
    );
  }
}

// class CricketHomePage extends StatefulWidget {
//   const CricketHomePage({super.key});

//   @override
//   State<CricketHomePage> createState() => _CricketHomePageState();
// }

// class _CricketHomePageState extends State<CricketHomePage> {
//  List<dynamic> dataList = [];
//   int intCount = 0;
//   int intlCount = 10;

//   int  tlength  =0;
//   List<dynamic> upcomingMatchData = [];

//   @override
//   void initState() {
//     super.initState();
//     getUpcomingMatch();
//      _scrollController.addListener(_scrollListener);
//   }

//   Future<void> getUpcomingMatch() async {
//     try {
//       // Replace this URL with your actual API endpoint
//       final response = await http.get(Uri.parse('http://apicricketchampion.in/apiv1/recentMatches/b832ce5e5bd1c05adb5b499a0b5ec563'));

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);

//         if (data['status'] == true) {
//            print(response.body);
//           setState(() {
//             upcomingMatchData = data['data'];
//             print(upcomingMatchData);
//             tlength = upcomingMatchData.length;
//             getEmployees();
//           });
//         } else {
//           print("Server backend API error");
//         }
//       } else {
//         print("Failed to load data. Server responded with status: ${response.statusCode}");
//       }
//     } catch (error) {
//       print("Error occurred during API call: $error");
//     }
//   }

//   void loadData() {
//     // Using settimeout to simulate API call
//     Future.delayed(Duration(milliseconds: 500), () {
//       setState(() {
//         intlCount += 10;
//         getEmployees();
//         if (dataList.length >= tlength) {
//            hasMoreData = false;
//         }
//       });
//     });
//   }

//   void getEmployees() {
//     for (int i = intCount; i < intlCount && i < upcomingMatchData.length; i++) {
//       dataList.add(upcomingMatchData[i]);
//     }
//     intCount = intlCount;
//   }

//   bool hasMoreData = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Page'),
//       ),
//       body: SizedBox(

//         height: 400,
//         child: ListView.builder(
//           itemCount: dataList.length + (hasMoreData ? 1 : 0),
//           itemBuilder: (context, index) {
//             if (index == dataList.length) {
//               // This is the loader at the end of the list
//               return const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Center(child: CircularProgressIndicator()),
//               );
//             } else {
//               // This is your regular list item
//               return ListTile(
//                 title: Text(
//                   dataList[index]["series"].toString(),
//                   style: TextStyle(color: Colors.red),
//                 ),
//                 leading:Text( dataList[index]["series_id"].toString(),  style: TextStyle(color: Colors.white)),
//                subtitle:Text( dataList[index]["match_date"].toString(),  style: TextStyle(color: Colors.white))

//               );
//             }
//           },
//           controller: _scrollController,
//         ),
//       ),
//     );
//   }
//   final ScrollController _scrollController = ScrollController();

//   void _scrollListener() {
//     // If the user scrolls to the end of the list and more data is available, load more
//     if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
//       if (hasMoreData) {
//         loadData();
//       }
//     }
//   }
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
// }
